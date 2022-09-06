import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mojtama/pages/adminScreens/change_month.dart';

class FormValidator extends GetxController {
  String? value;
  String? errorText;
  nullChecker() {
    errorText = null;
    if (value != "") return null;
    errorText = "فیلد خالی است.";
    return errorText;
  }

  updateState() {
    update();
  }
}

class NameFamilyValidator extends FormValidator {
  nameFamilyChecker() {
    errorText = null;
    if (value!.isEmpty) {
      errorText = "فیلد خالی است.";
    } else if (!value!.contains(RegExp(r'[ا-ی]'))) {
      errorText = "به فارسی وارد شود!";
    }
    return errorText;
  }
}

class UsernameValidator extends FormValidator {
  charsChecker() {
    errorText = null;
    if (!value!.contains(RegExp(r'[a-z]'))) {
      errorText = "به لاتین وارد کنید!!";
    }
    return errorText;
  }
}

class MobileValidator extends FormValidator {
  mobileChecker() {
    errorText = null;
    if (value!.isEmpty) {
      errorText = "فیلد خالی است.";
    } else if (!value!.isPhoneNumber) {
      errorText = "شماره تلفن اشتباه است.";
    }
    return errorText;
  }
}
