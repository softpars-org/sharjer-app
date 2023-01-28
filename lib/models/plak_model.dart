import 'package:flutter/material.dart';

class PlakModel extends ChangeNotifier {
  TextEditingController iranController = TextEditingController();
  TextEditingController char3 = TextEditingController();
  TextEditingController char = TextEditingController();
  TextEditingController lastNumber = TextEditingController();

  String get carPlate {
    String charValue = char.text;
    String threeCharsValue = char3.text;
    String iranValue = iranController.text;
    String lastNumberValue = lastNumber.text;
    return "$lastNumberValue|$charValue|$threeCharsValue|$iranValue";
  }
}
