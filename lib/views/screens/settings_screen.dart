import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/screens/auth_screens/change_password.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

var box = Hive.box("theme");

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تنظیمات",
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: 50,
              height: 50,
            ),
          ),
          const Divider(
            indent: 8,
            endIndent: 8,
            height: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(7),
            child: Consumer<ThemeModel>(builder: (context, model, child) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  "تم تیره: ",
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
                leading: const Icon(
                  Icons.dark_mode,
                ),
                subtitle: !model.isDarkMode
                    ? const Text(
                        "برای کمتر آسیب دیدن چشم، توصیه می‌شود تم تیره را فعال کنید.")
                    : null,
                trailing: Checkbox(
                  value: model.isDarkMode,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (x) {
                    model.toggleTheme();
                    // SystemChrome.setSystemUIOverlayStyle(
                    //   SystemUiOverlayStyle.light,
                    // ); TODO after update flutter to 3.0
                  },
                ),
                horizontalTitleGap: 2,
                onTap: () {
                  model.toggleTheme();
                },
              );
            }),
          ),
          const Divider(
            height: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text("راه ارتباطی با برنامه‌نویس در پیامرسان بله"),
              subtitle: const Text(
                  "اطلاعات کامل سفارش خود را به پیوی ارسال نمایید. (با فشردن این قسمت وارد محیط برنامه بله شوید.)"),
              onTap: () {
                launchUrlString("http://ble.im/JohnPeterson",
                    mode: LaunchMode.externalNonBrowserApplication);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Icon(Icons.password_outlined),
              title: const Text("تغییر رمز عبور"),
              subtitle: const Text(
                  "با فشردن این قسمت وارد صفحه تغییر رمز عبور خود شوید."),
              onTap: () {
                AppService(context).navigate(ChangePasswordScreen());
              },
            ),
          ),
          const Divider(
            height: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          UpdateApp(),
        ],
      ),
    );
  }
}

class UpdateApp extends StatelessWidget {
  @override
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userProvider.appVersionCalculator(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data["status"] == "updated") {
            return Container(
              child: TextButton(
                child: const Text("نسخه اپلیکیشن شما به روز می‌باشد."),
                onPressed: () {},
              ),
            );
          } else if (snapshot.data["status"] == "not updated") {
            return Container(
              child: TextButton(
                child: Text(
                    "${"نسخه‌ی اپلیکیشن شما: " + snapshot.data["given_version"]}. (برای دانلود، ضربه بزنید)"),
                onPressed: () {
                  launchUrlString(snapshot.data["app_link"],
                      mode: LaunchMode.externalApplication);
                },
              ),
            );
          }
        } else {
          return SpinKitCircle(
            color: Theme.of(context).primaryColor,
            size: 25,
          );
        }
        return Container();
      },
    );
  }
}
