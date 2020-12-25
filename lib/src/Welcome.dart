import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './Widget/RedBigButton.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';
import 'Widget/bezierContainer.dart';

final storage = FlutterSecureStorage();

class WelcomePage extends StatelessWidget {

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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You can share message, why not blood!',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: RedBigButton(text: "Login"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: RedBigButton(text: "Registration"),
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
