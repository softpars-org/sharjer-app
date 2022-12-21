import 'package:flutter/material.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_month_screen.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_price_screen.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_whole_months_screen.dart';
import 'package:mojtama/views/screens/admin_panel/financial_status/financial_status_screen.dart';
import 'package:mojtama/views/screens/admin_panel/mojtama_rules/mojtama_rules_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/add_charge_to_user_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/remove_charge_from_user_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/users_list_screen.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';

class AdminPanelScreen extends StatelessWidget {
  AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List items = [
      {
        "onPressed": () {
          AppService appService = AppService(context);
          appService.navigate(UsersListScreen());
        },
        "title": "لیست اعضا",
        "icon": Icons.group_outlined,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(ChangeMonthScreen());
        },
        "title": "تغییر ماه شارژ",
        "icon": Icons.date_range,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(ChangePriceScreen());
        },
        "title": "تغییر میزان شارژ",
        "icon": Icons.change_circle_outlined,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(ChangeWholeMonthsScreen());
        },
        "title": "تغییر ماه‌های شارژ",
        "icon": Icons.change_circle_outlined,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(AddChargeToUserScreen());
        },
        "title": "اضافه کردن شارژ به کاربر",
        "icon": Icons.add_rounded,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(RemoveChargeFromUserScreen());
        },
        "title": "حذف شارژ کاربر",
        "icon": Icons.delete_sweep_rounded,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(MojtamaRulesScreen());
        },
        "title": "قوانین مجتمع",
        "icon": Icons.rule,
      },
      {
        "onPressed": () {
          AppService service = AppService(context);
          service.navigate(FinancialAdminStatusScreen());
        },
        "title": "وضعیت مالی مجتمع",
        "icon": Icons.assignment,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("مدیریت"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Item(
          title: items[index]["title"],
          icon: items[index]["icon"],
          onPressed: items[index]["onPressed"],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  String? title;
  IconData? icon;
  Function()? onPressed;
  Item({super.key, this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButton(
        onPressed: onPressed ?? () {},
        text: title,
        icon: icon,
      ),
    );
  }
}
