import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//This class would act as the the scrolling behaviour on Desktop.
class CustomScrollBehaviour extends MaterialScrollBehavior {
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
