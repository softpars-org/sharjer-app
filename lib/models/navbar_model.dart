import 'package:flutter/material.dart';
import 'package:mojtama/views/screens/dashboard_screen.dart';
import 'package:mojtama/views/screens/payment/mojtama_finance_screen.dart';
import 'package:mojtama/views/screens/payment/payment_screen.dart';
import 'package:mojtama/views/screens/payment/payment_status_screen.dart';
import 'package:mojtama/views/screens/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBarModel {
  BuildContext? context;
  List<Widget> get screens {
    return [
      DashboardScreen(),
      PaymentScreen(),
      PaymentStatusScreen(),
      MojtamaFinanceScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> get items {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dashboard_outlined),
        title: "پیشخان",
        activeColorPrimary: Theme.of(context!).primaryColor,
        inactiveColorPrimary: Color.fromARGB(255, 196, 190, 183),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.credit_card_outlined),
        title: "پرداخت شارژ",
        activeColorPrimary: Theme.of(context!).primaryColor,
        inactiveColorPrimary: Color.fromARGB(255, 196, 190, 183),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.insert_chart_outlined),
        title: "وضعیت شارژ",
        activeColorPrimary: Theme.of(context!).primaryColor,
        inactiveColorPrimary: Color.fromARGB(255, 196, 190, 183),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.domain_outlined),
        title: "وضعیت مالی مجتمع",
        activeColorPrimary: Theme.of(context!).primaryColor,
        inactiveColorPrimary: Color.fromARGB(255, 196, 190, 183),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings_outlined),
        title: "تنظیمات",
        activeColorPrimary: Theme.of(context!).primaryColor,
        inactiveColorPrimary: Color.fromARGB(255, 196, 190, 183),
      ),
    ];
  }
}
