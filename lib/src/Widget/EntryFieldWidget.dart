import 'package:flutter/material.dart';

class EntryFieldWidget extends StatelessWidget {
  const EntryFieldWidget({
    Key key,
    @required this.title,
    @required this.isPassword,
    @required this.tc,
  }) : super(key: key);

  final String title;
  final bool isPassword;
  final tc;

  @override
  Widget build(BuildContext context) {
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
}
