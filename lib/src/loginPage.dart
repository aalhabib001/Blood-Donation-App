import 'package:flutter/material.dart';
//import 'package:flutter_login_signup/src/signup.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}
