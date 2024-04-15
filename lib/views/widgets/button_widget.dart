import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final IconData? icon;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    this.text,
    this.widget,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: widget ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text ?? "هیچ چیز"),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(icon),
                ),
              ],
            ),
      ),
    );
  }
}
