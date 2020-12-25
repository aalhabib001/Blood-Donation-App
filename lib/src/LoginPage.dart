import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './Networking/NetworkHandling.dart';
import './Widget/EntryFieldWidget.dart';
import './Widget/RedBigButton.dart';
import 'DonationInfoPage.dart';
import 'Model/DonationData.dart';
import 'Widget/bezierContainer.dart';

const SERVER_IP = 'https://blood-donation-backend-se231.herokuapp.com/api';
final storage = FlutterSecureStorage();

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'asset/l2.png',
                    height: 88,
                    width: 88,
                  ),
                  EntryFieldWidget(
                    title: 'Email',
                    isPassword: false,
                    tc: _emailController,
                  ),
                  EntryFieldWidget(
                      title: 'Password',
                      isPassword: true,
                      tc: _passwordController),
                  //SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      var email = _emailController.text;
                      var password = _passwordController.text;

                      var jwt = await attemptLogIn(email, password);
                      print(jwt);

                      if (jwt != null) {
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
                    child: RedBigButton(
                      text: "Login",
                    ),
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
