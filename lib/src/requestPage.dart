import 'package:flutter/material.dart';
//import 'package:flutter_login_signup/src/signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:convert' ;


import 'Widget/bezierContainer.dart';


const SERVER_IP = 'https://blood-donation-backend-se231.herokuapp.com/api';
final storage = FlutterSecureStorage();

class RequestPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _entryField(String title, bool isPassword, var tc) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xffFF5151),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: isPassword,
              controller: tc,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Color(0xffEEE6E6),
                  filled: true),
            )
          ],
        ));
  }

  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
        'Make Request',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Future<String> attemptLogIn(String email, String password) async {
    print('Hi');
    Map<String,String> headers = {'Content-Type':'application/json'};
    final msg = jsonEncode({"email":email,"password":password});
    var res = await http.post(
        "$SERVER_IP/auth/login",
        body: msg,
        headers: headers
    );
    print(res.statusCode);

    if(res.statusCode == 200){
      Map<String, dynamic> response = jsonDecode(res.body);

      String jwt = response['token'];
      return jwt;

    }
    return null;
  }

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    '',
                    height: 2,
                    width: 2,
                  ),
                  _entryField('Blood Group', false, _emailController),
                  _entryField('Hospital', false, _emailController),
                  _entryField('Address', false, _emailController),
                  _entryField('Division', true, _passwordController),
                  _entryField('Phone', true, _passwordController),
                  _entryField('Description', true, _passwordController),
                  //SizedBox(height: 15),
                  GestureDetector(
                      onTap: () async {
                        var email = _emailController.text;
                        var password = _passwordController.text;

                        var jwt = await attemptLogIn(email, password);
                        print(jwt);

                        if(jwt != null) {
                          storage.write(key: "jwt", value: jwt);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage.fromBase64(jwt)
                              )
                          );
                        } else {
                          displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                        }
                      },
                      child: _registerButton()
                  )
                ],
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
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              future: http.read('$SERVER_IP/auth/data', headers: {"Authorization": jwt}),
              builder: (context, snapshot) =>
              snapshot.hasData ?
              Column(children: <Widget>[
                Text("${payload['data']}, here's the data:"),
                Text(snapshot.data, style: Theme.of(context).textTheme.display1)
              ],)
                  :
              snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
          ),
        ),
      );
}