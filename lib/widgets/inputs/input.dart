import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    @required TextEditingController emailController,
    @required String validatorText,
    @required String hintText,
    @required TextInputType keyboardType,
    @required bool isValid,
    bool isObscureText = false,
  })  : _emailController = emailController,
        _validatorText = validatorText,
        _hintText = hintText,
        _keyboardType = keyboardType,
        _isValid = isValid,
        _isObscureText = isObscureText,
        super(key: key);

  final TextEditingController _emailController;
  final String _validatorText;
  final String _hintText;
  final TextInputType _keyboardType;
  final bool _isValid;
  final bool _isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      cursorColor: Color(0xFFFEFEFE),
      keyboardType: _keyboardType,
      style: TextStyle(color: Color(0xFFFEFEFE)),
      autovalidate: true,
      autocorrect: false,
      obscureText: _isObscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        labelStyle: TextStyle(color: Color(0xFFFEFEFE)),
        hintText: _hintText,
        fillColor: Color(0xFF1A262E),
        hintStyle: TextStyle(color: Color(0xFFFEFEFE)),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
      validator: (_) {
        return !_isValid ? _validatorText : null;
      },
    );
  }
}