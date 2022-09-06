import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/dashboard.dart';
import 'package:mojtama/pages/login.dart';
import 'package:mojtama/pages/payment.dart';
import 'package:mojtama/pages/settings.dart';
import 'package:mojtama/pages/statusPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> widgets = [
    LogginedPage(),
    PaymentPage(),
    StatusPageUser(),
    SettingsPage(),
  ];
  List<PersistentBottomNavBarItem> items = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.dashboard),
      title: "پیش‌خوان",
      activeColorPrimary: Colors.cyan,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.credit_card),
      title: "پرداخت شارژ",
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.assignment_outlined),
      title: "وضعیت شارژ",
      inactiveColorPrimary: Colors.grey,
      activeColorPrimary: Colors.red,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.settings_outlined),
      title: "تنظیمات",
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}
