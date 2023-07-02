import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/permission_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_month_screen.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_price_screen.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/change_whole_months_screen.dart';
import 'package:mojtama/views/screens/admin_panel/financial_status/financial_status_screen.dart';
import 'package:mojtama/views/screens/admin_panel/mojtama_rules/mojtama_rules_screen.dart';
import 'package:mojtama/views/screens/admin_panel/notifications/send_notification_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/users_list_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  late PermissionModel provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<PermissionModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    bool isFullAdmin = provider.userPermissionType == "full";
    List items = [
      {
        "onPressed": () {
          AppService appService = AppService(context);
          appService.navigate(const UsersListScreen());
        },
        "title": "لیست اعضا",
        "icon": Icons.group_outlined,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(const ChangeMonthScreen());
              }
            : null,
        "title": "تغییر ماه شارژ",
        "icon": Icons.date_range,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(ChangePriceScreen());
              }
            : null,
        "title": "تغییر میزان شارژ",
        "icon": Icons.change_circle_outlined,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(SendNotificationScreen());
              }
            : null,
        "title": "ارسال اعلان",
        "icon": Icons.notifications,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(const ChangeWholeMonthsScreen());
              }
            : null,
        "title": "تغییر ماه‌های شارژ",
        "icon": Icons.change_circle_outlined,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(MojtamaRulesScreen());
              }
            : null,
        "title": "قوانین مجتمع",
        "icon": Icons.rule,
      },
      {
        "onPressed": isFullAdmin
            ? () {
                AppService service = AppService(context);
                service.navigate(const FinancialAdminStatusScreen());
              }
            : null,
        "title": "وضعیت مالی مجتمع",
        "icon": Icons.assignment,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("مدیریت"),
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
  final String? title;
  final IconData? icon;
  final Function()? onPressed;
  const Item({super.key, this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButton(
        onPressed: onPressed,
        text: title,
        icon: icon,
      ),
    );
  }
}
