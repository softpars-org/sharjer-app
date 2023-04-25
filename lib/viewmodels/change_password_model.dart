import 'package:flutter/material.dart';
import 'package:mojtama/services/user_api_service.dart';

class ChangePasswordModel extends ChangeNotifier {
  String plainPassword = "";
  changePlainPassword(String newPlainPassword) {
    plainPassword = newPlainPassword;
    notifyListeners();
  }
}
