import 'package:flutter/material.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/models/permission_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/viewmodels/who_didnt_pay_model.dart';
import 'package:mojtama/views/screens/admin_panel/main_screen.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/screens/payment_history_screen.dart';
import 'package:mojtama/views/screens/profile_screen.dart';
import 'package:mojtama/views/screens/who_didnt_pay_charge_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
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
        title: const Text("پیشخان"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadResources(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Center(
                child: Consumer<PaymentModel>(
                  builder: (context, model, child) {
                    return Visibility(
                      visible: !model.isLoading,
                      replacement: CircularProgressIndicator(),
                      child: Text(
                        model.paymentStat,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Consumer<PermissionModel>(builder: (context, model, child) {
              if (model.userPermissionType != "no") {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    icon: Icons.admin_panel_settings_outlined,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPanelScreen(),
                        ),
                      );
                    },
                    text: "مدیریت",
                  ),
                );
              } else {
                return Container();
              }
            }),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                icon: Icons.person_outline,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                text: "پروفایل",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<WhoDidntPayChargeModel>(
                          create: (_) => WhoDidntPayChargeModel(),
                          child: WhoDidntPayChargeScreen(),
                        ),
                      ));
                },
                icon: Icons.person_pin_circle_outlined,
                text: "افراد پرداخت نکننده شارژ",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentHistoryScreen(),
                    ),
                  );
                },
                icon: Icons.history_edu_rounded,
                text: "آخرین پرداختی‌های شارژ",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
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
