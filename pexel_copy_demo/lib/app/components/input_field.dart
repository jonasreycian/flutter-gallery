import 'package:flutter/material.dart';

import '../../data/utils/constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final FocusNode _focusNode;
  final TextInputType type;
  final bool isPassword;

  const InputField(
    this._controller,
    this._hintText,
    this._focusNode, {
    Key? key,
    this.isPassword = false,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      child: TextFormField(
        keyboardType: type,
        controller: _controller,
        focusNode: _focusNode,
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8)),
          ),
          fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
          filled: true,
          hintText: _hintText,
          hintStyle: UIConstants.fieldHintStyle,
        ),
      ),
    );
  }
}
