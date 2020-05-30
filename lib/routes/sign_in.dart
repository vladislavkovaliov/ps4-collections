import 'package:flutter/material.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';
import 'package:ps4_collection/widgets/forgot_password_and_redirect/forgot_password_and_redirect.dart';

class SignIn extends StatelessWidget {
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
                text: "Sign In",
                onPressed: () {},
              ),
              SizedBox(
                height: 32,
              ),
              ForgotPasswordAndRedirect(
                onRedirectTap: () {
                  Navigator.pushNamed(context, '/signUp');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
