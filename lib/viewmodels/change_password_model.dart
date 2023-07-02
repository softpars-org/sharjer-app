import 'package:flutter/material.dart';

class ChangePasswordModel extends ChangeNotifier {
  String plainPassword = "";
  changePlainPassword(String newPlainPassword) {
    plainPassword = newPlainPassword;
    notifyListeners();
  }
}
