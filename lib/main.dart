import 'package:flutter/material.dart';
import 'package:ps4_collection/routes/sign_in.dart';
import 'package:ps4_collection/routes/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF192229),
        primaryColor: Color(0xFF192229),
      ),
      initialRoute: '/signIn',
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
      },
    );
  }
}
