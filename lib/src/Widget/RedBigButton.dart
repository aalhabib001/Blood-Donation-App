import 'package:flutter/material.dart';

class RedBigButton extends StatelessWidget {
  const RedBigButton({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  Widget build(BuildContext context) {
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
      child: Text(text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
