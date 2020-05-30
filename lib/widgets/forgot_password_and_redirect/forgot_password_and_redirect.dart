import 'package:flutter/material.dart';

class ForgotPasswordAndRedirect extends StatelessWidget {
  final Function onRedirectTap;

  const ForgotPasswordAndRedirect({
    Key key,
    @required this.onRedirectTap,
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
            "Sign Up",
            style: TextStyle(color: Color(0xFFFEFEFE)),
          ),
        ),
      ],
    );
  }
}
