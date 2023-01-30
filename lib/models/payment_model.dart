import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/history_model.dart';
import 'package:mojtama/services/payment_api_service.dart';
import 'package:mojtama/services/user_api_service.dart';

//this model is used for payment functionalities
class PaymentModel extends ChangeNotifier {
  String currentMonth = "";
  bool isLoading = false;

  String paymentStat = "";
  List<History> paymentHistory = [];
  List<ChargeRowStatus> chargeStatusOfTheUser = [];

  getPaymentStatusOfTheUsersInTheMonth() async {
    UserProvider userProvider = UserProvider();
    String? ans = await userProvider.getPaymentStatusMessageOfTheUsers();
    if (ans != null) {
      paymentStat = ans;
      notifyListeners();
    }
  }

  getChargeStatusOfTheUser() async {
    UserProvider userProvider = UserProvider();
    chargeStatusOfTheUser = await userProvider.getUserChargeStatus();
    if (chargeStatusOfTheUser != false) {
      notifyListeners();
    }
  }

  getCurrentMonth() async {
    PaymentProvider paymentProvider = PaymentProvider();
    toggleLoading();
    String _month = await paymentProvider.getCurrentMonth();
    toggleLoading();
    currentMonth = _month;
    notifyListeners();
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  getPaymentHistory() async {
    PaymentProvider provider = PaymentProvider();
    var histories = await provider.getPaymentHistory();
    if (histories != false) {
      paymentHistory = histories;
      notifyListeners();
    }
  }
}
