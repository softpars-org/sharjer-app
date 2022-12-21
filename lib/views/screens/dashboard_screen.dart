import 'package:flutter/material.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/admin_panel/main_screen.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/screens/payment_history_screen.dart';
import 'package:mojtama/views/screens/profile_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("پیشخان"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => print("refreshed!"),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "۲۴ نفر در این ماه شارژ‌ را پرداخت کرده‌اند.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                icon: Icons.admin_panel_settings_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPanelScreen(),
                    ),
                  );
                },
                text: "مدیریت",
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                icon: Icons.person_outline,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                text: "پروفایل",
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentHistoryScreen(),
                    ),
                  );
                },
                icon: Icons.history_edu_rounded,
                text: "آخرین پرداختی‌های شارژ",
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                icon: Icons.exit_to_app_rounded,
                onPressed: () {
                  AppService appService = AppService(context);
                  appService.navigateReplace(LoginPage());
                },
                text: "خروج",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
