import 'package:flutter/material.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/models/permission_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/admin_panel/main_screen.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/screens/payment_history_screen.dart';
import 'package:mojtama/views/screens/profile_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var paymentProvider = Provider.of<PaymentModel>(context, listen: false);
    var permissionProvider =
        Provider.of<PermissionModel>(context, listen: false);
    await paymentProvider.getPaymentStatusOfTheUsersInTheMonth();
    await permissionProvider.fetchUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("پیشخان"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadResources(),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Consumer<PaymentModel>(
                  builder: (context, model, child) {
                    return Text(
                      model.paymentStat,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Consumer<PermissionModel>(builder: (context, model, child) {
              return model.userPermissionType != "no"
                  ? Padding(
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
                    )
                  : Container();
            }),
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
                  appService.deleteAuthBox();
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
