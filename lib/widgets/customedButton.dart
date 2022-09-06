import 'package:flutter/material.dart';

class CustomedButton extends StatelessWidget {
  @override
  Widget? child;
  EdgeInsets? padding;
  EdgeInsets? margin;
  Function()? onPressed;
  CustomedButton({
    this.child,
    this.padding,
    this.onPressed,
    this.margin,
  });
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all(padding)),
        child: child!,
      ),
    );
  }
}
