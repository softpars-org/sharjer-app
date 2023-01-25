import 'package:flutter/material.dart';

class MonthsModel extends ChangeNotifier {
  List<bool> checkMonths = List<bool>.generate(12, (index) => false);
  Map<int, String> months = Map<int, String>();
  Map<String, int> monthsPricesDetails = {};
  List<String> monthsStrings = [
    "محرم",
    "صفر",
    "ربیع الاول",
    "ربیع الثانی",
    "جمادی الاول",
    "جمادی الثانی",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذیحجه",
    "ذیقعده"
  ];
  List yearMonthsDetails =
      []; /* to implement a concept which 
  can communicate with server side */

  update() {
    notifyListeners();
  }

  changeMonthsPricesValue(Map<String, int> newMonthsPricesValue) {
    monthsPricesDetails = newMonthsPricesValue;
    notifyListeners();
  }

  add(month) {
    int index = 0;
    if (month == "محرم") index = 0;
    if (month == "صفر") index = 1;
    if (month == "ربیع الاول") index = 2;
    if (month == "ربیع الثانی") index = 3;
    if (month == "جمادی الاول") index = 4;
    if (month == "جمادی الثانی") index = 5;
    if (month == "رجب") index = 6;
    if (month == "شعبان") index = 7;
    if (month == "رمضان") index = 8;
    if (month == "شوال") index = 9;
    if (month == "ذیقعده") index = 10;
    if (month == "ذیحجه") index = 11;
    months.addAll({index: month});
    notifyListeners();
  }

  remove(month) {
    int index = 0;
    if (month == "محرم") index = 0;
    if (month == "صفر") index = 1;
    if (month == "ربیع الاول") index = 2;
    if (month == "ربیع الثانی") index = 3;
    if (month == "جمادی الاول") index = 4;
    if (month == "جمادی الثانی") index = 5;
    if (month == "رجب") index = 6;
    if (month == "شعبان") index = 7;
    if (month == "رمضان") index = 8;
    if (month == "شوال") index = 9;
    if (month == "ذیقعده") index = 10;
    if (month == "ذیحجه") index = 11;
    months.removeWhere((key, value) => index == key);
    notifyListeners();
  }
}

class RadioMonthModel extends ChangeNotifier {
  List monthIndexes = List.generate(12, (index) => index);
  List months = [
    "محرم",
    "صفر",
    "ربیع الاول",
    "ربیع الثانی",
    "جمادی الاول",
    "جمادی الثانی",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذیقعده",
    "ذیحجه",
  ];
  int currentValue = 0;
  changeItem(newValue) {
    currentValue = newValue;
    notifyListeners();
  }
}
