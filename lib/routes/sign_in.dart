import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/blocs/authentication/authentication_bloc.dart';
import 'package:ps4_collection/blocs/authentication/authentication_event.dart';
import 'package:ps4_collection/blocs/login/bloc.dart';
import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:ps4_collection/routes/sign_up.dart';
import 'package:ps4_collection/widgets/buttons/button.dart';
import 'package:ps4_collection/widgets/forgot_password_and_redirect/forgot_password_and_redirect.dart';

class SignIn extends StatelessWidget {
  final UserRepository _userRepository;

  SignIn({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    print(this._userRepository);

    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: this._userRepository),
        child: SignInForm(userRepository: _userRepository,),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignInForm({UserRepository userRepository })
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

  getInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(12),
      labelStyle: TextStyle(color: Color(0xFFFEFEFE)),
      hintText: hintText,
      fillColor: Color(0xFF353A47),
      hintStyle: TextStyle(color: Color(0xFFFEFEFE)),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
        const BorderRadius.all(Radius.circular(30)),
      ),
    );
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
                      decoration: this.getInputDecoration("Email address"),
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
                      decoration: this.getInputDecoration("Password"),
                      validator: (_) {
                        return !state.isPasswordValid ? 'Invalid Password' : null;
                      },
                    ),
                    SizedBox(height: 16,),
                    Button(
                      text: "Sign In",
                      onPressed: this.isLoginButtonEnabled(state)
                        ? this._onFormSubmitted
                        : null,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ForgotPasswordAndRedirect(
                        text: "Sign Up",
                        onRedirectTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return SignUp(userRepository: _userRepository);
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
