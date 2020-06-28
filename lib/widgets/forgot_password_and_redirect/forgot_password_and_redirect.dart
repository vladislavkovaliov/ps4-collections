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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot password?",
          style: TextStyle(color: Color(0xFF576875)),
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: this.onRedirectTap,
          child: Text(
            this.text,
            style: TextStyle(color: Color(0xFF576875)),
          ),
        ),
      ],
    );
  }
}
