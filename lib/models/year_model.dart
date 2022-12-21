import 'package:flutter/material.dart';

class YearModel extends ChangeNotifier {
  String year = "1444";
  changeYear(newYear) {
    year = newYear;
    notifyListeners();
  }
}
