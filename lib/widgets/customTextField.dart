import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/utils/util.dart';

class CustomedTextField extends StatelessWidget {
  @override
  TextStyle? style = TextStyle();
  String? label;
  String? helper;
  Icon? icon;
  bool obscureText;
  TextDirection dir;
  TextEditingController? controller;
  int maxLines;
  TextInputType? keyboardType;
  Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatter;
  String? errorMsg;

  CustomedTextField({
    this.label,
    this.style,
    this.icon,
    this.helper,
    this.controller,
    this.obscureText = false,
    this.dir = TextDirection.rtl,
    this.maxLines = 1,
    this.onChanged,
    this.inputFormatter,
    this.errorMsg,
    this.keyboardType,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      textAlignVertical: TextAlignVertical.top,
      cursorColor: Colors.blue,
      cursorWidth: 1.2,
      textAlign: TextAlign.right,
      style: style,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      textDirection: dir,
      onChanged: onChanged,
      maxLines: maxLines,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        suffixIcon: icon,
        //hintText: "نام کاربری خود را وارد کنید",
        labelStyle: style,
        errorText: errorMsg,

        labelText: label,
        helperText: helper,
        helperMaxLines: 3,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class CustomedTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  String? helperText;
  Function(String)? onChanged;
  CustomedTextFormField({
    this.controller,
    this.label,
    this.helperText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      maxLines: 5,
      onChanged: onChanged,
      autofocus: false,
      cursorColor: Colors.blue,
      cursorWidth: 1.2,
      textAlign: TextAlign.right,
      style: TextStyleX.style,
      controller: controller,
      decoration: InputDecoration(
        //hintText: "نام کاربری خود را وارد کنید",
        labelStyle: TextStyleX.style,
        labelText: label,
        helperText:
            helperText, //"برای مثال: شارژ رمضان و شوال ۱۴۴۳ به دلیل ... در وقت مقرر پرداخت نشد.",
        helperMaxLines: 4,
        alignLabelWithHint: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
