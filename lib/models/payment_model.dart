import 'dart:math';

import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  String? _text = "ربیع";
  String get text => _text!;
  List testMonths = ["ربیع", "تست", "علی"];
  randomText() {
    Random rand = Random();
    int randomIndex = rand.nextInt(testMonths.length);
    _text = testMonths[randomIndex];
    notifyListeners();
  }
}
