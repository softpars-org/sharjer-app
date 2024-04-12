import 'package:flutter/material.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/services/user_api_service.dart';

class YearModel extends ChangeNotifier {
  String year = "1444";
  List<dynamic> years = [];
  changeYear(newYear) {
    year = newYear;
    notifyListeners();
  }

  getYears(BuildContext context) async {
    UserProvider userProvider = UserProvider(
      snackbarService: SnackbarService(context),
    );
    List<dynamic> yearsFromAPI = await userProvider.getYears();
    years = yearsFromAPI;
    notifyListeners();
  }
}
