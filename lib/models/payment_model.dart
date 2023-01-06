import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/services/payment_api_service.dart';
import 'package:mojtama/services/user_api_service.dart';

class PaymentModel extends ChangeNotifier {
  String currentMonth = "";
  bool isLoading = false;

  String paymentStat = "";
  List<ChargeRowStatus> chargeStatusOfTheUser = [];

  getPaymentStatusOfTheUsersInTheMonth() async {
    UserProvider userProvider = UserProvider();
    String? ans = await userProvider.getPaymentStatusMessageOfTheUsers();
    print(ans);
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
}
