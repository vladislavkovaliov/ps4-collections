import 'package:flutter/material.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                text: "Sign Up",
                onPressed: () {},
              ),
              SizedBox(
                height: 32,
              ),
              Redirect(
                text: "Sign Up",
                onRedirectTap: () {
                  Navigator.pushNamed(context, '/signIn');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Redirect extends StatelessWidget {
  final Function onRedirectTap;
  final String text;

  const Redirect({
    Key key,
    @required this.onRedirectTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onRedirectTap,
      child: Text(
        this.text,
        style: TextStyle(color: Color(0xFFFEFEFE)),
      ),
    );
  }
}

