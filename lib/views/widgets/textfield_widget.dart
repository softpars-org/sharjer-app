import 'dart:async';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  String? helper;
  bool obscureText;
  Icon? suffixIcon;
  int? maxLines;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  CustomTextField({
    super.key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.helper,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      cursorRadius: Radius.circular(50),
      decoration: InputDecoration(
        label: Text(
          label ?? "هیچ",
        ),
        alignLabelWithHint: true,
        suffixIcon: suffixIcon,
        helperText: helper,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
