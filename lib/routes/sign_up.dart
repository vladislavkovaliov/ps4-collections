import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/blocs/authentication/bloc.dart';
import 'package:ps4_collection/blocs/register/bloc.dart';
import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:ps4_collection/routes/sign_in.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';
import 'package:ps4_collection/widgets/inputs/input.dart';

import 'package:ps4_collection/widgets/forgot_password_and_redirect/forgot_password_and_redirect.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;
  final String text;

  SignUp({this.text, UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: this._userRepository),
          child: SignUpForm(),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignUpForm({UserRepository userRepository })
      : _userRepository = userRepository;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  getInputShadow() {
    return new BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.2),
          blurRadius: 25.0, // soften the shadow
          spreadRadius: 0.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            4.0, // Move to bottom 10 Vertically
          ),
        )
      ],
    );
  }

  getPadding() {
    return EdgeInsets.symmetric(horizontal: 40);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: this.getPadding(),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Container(
                    padding: this.getPadding(),
                    decoration: this.getInputShadow(),
                    child: Input(
                      emailController: _emailController,
                      validatorText: "Invalid Email",
                      hintText: "Email address",
                      keyboardType: TextInputType.emailAddress,
                      isValid: state.isEmailValid,
                    ),
                  ),
                  SizedBox(   height: 27,),
                  Container(
                    padding: this.getPadding(),
                    decoration: this.getInputShadow(),
                    child: Input(
                      emailController: _passwordController,
                      validatorText: "Invalid Password",
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      isValid: state.isPasswordValid,
                      isObscureText: true,
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: 200,
                    child: Button(
                      text: "Sign Up",
                      onPressed: this.isRegisterButtonEnabled(state)
                          ? this._onFormSubmitted
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: this.getPadding(),
                    child: ForgotPasswordAndRedirect(
                        text: "Sign In",
                        onRedirectTap: () {
                          Navigator.of(context).pop(
                              MaterialPageRoute(builder: (context) {
                                return SignIn(userRepository: _userRepository);
                              })
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

