import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mojtama/services/user_api_service.dart';

class PaymentModel extends ChangeNotifier {
  String? _text = "ربیع";
  String get text => _text!;
  List testMonths = ["ربیع", "تست", "علی"];
  String paymentStat = "";
  getPaymentStatusOfTheUsersInTheMonth() async {
    UserProvider userProvider = UserProvider();
    String? ans = await userProvider.getPaymentStatusMessageOfTheUsers();
    print(ans);
    if (ans != null) {
      paymentStat = ans;
      notifyListeners();
    }
  }

  randomText() {
    Random rand = Random();
    int randomIndex = rand.nextInt(testMonths.length);
    _text = testMonths[randomIndex];
    notifyListeners();
  }
}
