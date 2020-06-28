import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/blocs/authentication/authentication_bloc.dart';
import 'package:ps4_collection/blocs/authentication/authentication_event.dart';
import 'package:ps4_collection/blocs/login/bloc.dart';
import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:ps4_collection/routes/sign_up.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';
import 'package:ps4_collection/widgets/inputs/input.dart';
import 'package:ps4_collection/widgets/forgot_password_and_redirect/forgot_password_and_redirect.dart';

class SignIn extends StatelessWidget {
  final UserRepository _userRepository;

  SignIn({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: this._userRepository),
        child: SignInForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignInForm({UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                  SizedBox(
                    height: 27,
                  ),
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
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 200,
                    child: Button(
                      text: "Sign In",
                      onPressed: this.isLoginButtonEnabled(state)
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
                        text: "Sign Up",
                        onRedirectTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignUp(userRepository: _userRepository);
                          }));
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
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
