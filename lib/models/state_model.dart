import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  List<bool> isOpen = [false, false];
  changeIsOpen(index, shouldOpen) {
    isOpen[index] = shouldOpen;
    notifyListeners();
  }
}
