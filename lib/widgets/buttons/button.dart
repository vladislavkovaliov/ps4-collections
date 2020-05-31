import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      disabledColor: Color(0xFF8F8F8F),
      child: RaisedButton(
        color: Color(0xFF659069),
        textColor: Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50),
        ),
        onPressed: this.onPressed,
        child: Center(
          child: Text(this.text),
        ),
      ),
    );
  }
}