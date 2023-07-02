import 'package:flutter/material.dart';

class PlakModel extends ChangeNotifier {
  TextEditingController iranController = TextEditingController();
  TextEditingController char3 = TextEditingController();
  TextEditingController char = TextEditingController();
  TextEditingController lastNumber = TextEditingController();
  String _carPlate = "";
  String get carPlate {
    String charValue = char.text;
    String threeCharsValue = char3.text;
    String iranValue = iranController.text;
    String lastNumberValue = lastNumber.text;
    _carPlate = "$iranValue|$threeCharsValue|$charValue|$lastNumberValue";
    return _carPlate;
  }

  setCarPlate(String newCarPlate) {
    List<String> carPlateValues = newCarPlate.split("|");
    iranController.text = carPlateValues[0];
    char3.text = carPlateValues[1];
    char.text = carPlateValues[2];
    lastNumber.text = carPlateValues[3];
    notifyListeners();
  }
}
