import 'dart:convert' show json, base64, ascii;
import 'dart:convert';

import 'package:blood_donation_app/src/Networking/NetworkHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'package:flutter_login_signup/src/signup.dart';
import 'package:http/http.dart' as http;

import './Widget/EntryFieldWidget.dart';
import 'DonationInfoPage.dart';
import 'Model/DonationData.dart';
import 'Widget/bezierContainer.dart';

const SERVER_IP = 'https://blood-donation-backend-se231.herokuapp.com/api';
final storage = FlutterSecureStorage();

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          color: Colors.red),
      child: Text(
        'Registration',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Future<String> attemptLogIn(String email, String password) async {
    print('Hi');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({"email": email, "password": password});
    var res =
        await http.post("$SERVER_IP/auth/login", body: msg, headers: headers);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(res.body);

      String jwt = response['token'];
      return jwt;
    }
    return null;
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -height * .25,
              right: -MediaQuery.of(context).size.width * .35,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   'asset/l2.png',
                    //   height: 110,
                    //   width: 100,
                    // ),
                    EntryFieldWidget(
                      title: "Name",
                      isPassword: false,
                      tc: _nameController,
                    ),
                    EntryFieldWidget(
                      title: "Email",
                      isPassword: false,
                      tc: _emailController,
                    ),
                    EntryFieldWidget(
                      title: "Phone",
                      isPassword: false,
                      tc: _phoneController,
                    ),
                    EntryFieldWidget(
                      title: "Password",
                      isPassword: true,
                      tc: _passwordController,
                    ),
                    //SizedBox(height: 15),
                    GestureDetector(
                        onTap: () async {
                          var email = _emailController.text;
                          var password = _passwordController.text;
                          var name = _nameController.text;
                          var phone = _phoneController.text;

                          var jwt = await attemptRegister(
                              name: name,
                              email: email,
                              phone: phone,
                              password: password);

                          print(jwt);

                          if (jwt != null) {
                            storage.write(key: "jwt", value: jwt);
                            List<DonationData> donationData =
                            await getData(jwtToken: jwt);
                            storage.write(key: "jwt_blood_app", value: jwt);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DonationInfoPage(donationData),
                              ),
                            );
                          } else {
                            displayDialog(context, "An Error Occurred",
                                "No account was found matching that username and password");
                          }
                        },
                        child: _registerButton())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) =>
      HomePage(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              future: http.read('$SERVER_IP/auth/data',
                  headers: {"Authorization": jwt}),
              builder: (context, snapshot) =>
              snapshot.hasData
                  ? Column(
                children: <Widget>[
                  Text("${payload['data']}, here's the data:"),
                  Text(snapshot.data,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1)
                ],
              )
                  : snapshot.hasError
                  ? Text("An error occurred")
                  : CircularProgressIndicator()),
        ),
      );
}
