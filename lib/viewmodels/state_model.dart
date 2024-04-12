import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mojtama/models/rule_model.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/services/user_api_service.dart';

class CheckboxModel extends ChangeNotifier {
  bool _isOwner = false;
  toggleCheckbox() {
    _isOwner = !_isOwner;
    notifyListeners();
  }

  bool get isOwner {
    return _isOwner;
  }
}

class MojtamaStatusExpansionModel extends ChangeNotifier {
  List<bool> isOpen = [true, true];
  bool isLoading = false;
  String financialStatusText = "{}";
  Rule mojtamaRule = Rule("", "", "", "", "");

  String? get _financialStatusText {
    return financialStatusText;
  }

  changeIsOpen(index, shouldOpen) {
    isOpen[index] = shouldOpen;
    notifyListeners();
  }

  getFinancialStatus(BuildContext context) async {
    toggleLoading();
    var response;
    try {
      response = await UserProvider(snackbarService: SnackbarService(context))
          .getFinancialStatus();
      toggleLoading();
    } catch (e) {
      return;
    }

    financialStatusText = jsonDecode(response)["data"];
    notifyListeners();
  }

  getRules(BuildContext context) async {
    toggleLoading();
    Rule? response;
    try {
      response = await UserProvider(snackbarService: SnackbarService(context))
          .getMojtamaRules();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    if (response != null) {
      toggleLoading();
      mojtamaRule = response;
      notifyListeners();
    }
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
