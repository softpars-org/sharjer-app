import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  @override
  bool isDark = Hive.box("theme").get("is_dark") ?? false;
  changeTheme() {
    isDark = !isDark;
    Hive.box("theme").put("is_dark", isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    update();
  }
}
