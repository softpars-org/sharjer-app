import 'package:flutter/material.dart';
import 'package:mojtama/services/payment_api_service.dart';

class WhoDidntPayChargeModel extends ChangeNotifier {
  Map<String, dynamic> users = {};
  bool isLoading = true;
  fetchPeopleWhoDidntPay() async {
    PaymentProvider provider = PaymentProvider();
    var response = await provider.getPeopleWhoDidntPayCharge();
    if (response != false) {
      users = response;
      print("response has gone to the users");
      toggleLoading();
    }
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
