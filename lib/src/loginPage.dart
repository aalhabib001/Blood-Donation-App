import 'package:flutter/material.dart';
//import 'package:flutter_login_signup/src/signup.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatelessWidget {
  Widget _entryField(String title, bool isPassword) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            SizedBox(height: 15),
            TextField(
              obscureText: isPassword,
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

  Widget _submitButton() {
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
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'asset/l2.png',
                    height: 100,
                    width: 100,
                  ),
                  _entryField('Email', false),
                  _entryField('Password', true),
                  //SizedBox(height: 15),
                  _submitButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
