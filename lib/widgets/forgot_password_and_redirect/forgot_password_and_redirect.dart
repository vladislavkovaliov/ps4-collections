import 'package:flutter/material.dart';

class ForgotPasswordAndRedirect extends StatelessWidget {
  final Function onRedirectTap;
  final String text;

  const ForgotPasswordAndRedirect({
    Key key,
    @required this.onRedirectTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Forgot password?",
          style: TextStyle(color: Color(0xFFFEFEFE)),
        ),
        Container(
          width: 2,
          height: 16,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: this.onRedirectTap,
          child: Text(
            this.text,
            style: TextStyle(color: Color(0xFFFEFEFE)),
          ),
        ),
      ],
    );
  }
}
