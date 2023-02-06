import 'package:flutter/material.dart';
import 'package:mojtama/services/user_api_service.dart';

class YearModel extends ChangeNotifier {
  String year = "1444";
  List<dynamic> years = [];
  changeYear(newYear) {
    year = newYear;
    notifyListeners();
  }

  getYears() async {
    UserProvider userProvider = UserProvider();
    List<dynamic> years = await userProvider.getYears();
    years = years;
    notifyListeners();
  }
}
