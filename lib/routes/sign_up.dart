import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/blocs/authentication/bloc.dart';
import 'package:ps4_collection/blocs/register/bloc.dart';
import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:ps4_collection/routes/sign_in.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';
import 'package:ps4_collection/widgets/forgot_password_and_redirect/forgot_password_and_redirect.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;
  final String text;

  SignUp({this.text, UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    print(this._userRepository);
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Color(0xFFFEFEFE),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(0xFFFEFEFE)),
                      autovalidate: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle: TextStyle(color: Color(0xFFFEFEFE)),
                          hintText: "Email address",
                          fillColor: Color(0xFF353A47),
                          hintStyle: TextStyle(color: Color(0xFFFEFEFE)),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                          )),
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Color(0xFFFEFEFE),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      autovalidate: true,
                      autocorrect: false,
                      style: TextStyle(color: Color(0xFFFEFEFE)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          labelStyle: TextStyle(color: Color(0xFFFEFEFE)),
                          hintText: "Password",
                          fillColor: Color(0xFF353A47),
                          hintStyle: TextStyle(color: Color(0xFFFEFEFE)),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          )
                      ),
                      validator: (_) {
                        return !state.isPasswordValid ? 'Invalid Password' : null;
                      },
                    ),
                    SizedBox(height: 16,),
                    Button(
                      text: "Sign Up",
                      onPressed: this.isRegisterButtonEnabled(state)
                          ? this._onFormSubmitted
                          : null,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ForgotPasswordAndRedirect(
                        text: "Sign In",
                        onRedirectTap: () {
                          Navigator.of(context).pop(
                              MaterialPageRoute(builder: (context) {
                                return SignIn(userRepository: _userRepository);
                              })
                          );
                        }),
                  ],
                ),
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

