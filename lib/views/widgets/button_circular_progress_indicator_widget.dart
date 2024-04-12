import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonCircularProgressIndicator extends StatelessWidget {
  const ButtonCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
