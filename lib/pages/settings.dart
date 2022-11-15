import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mojtama/utils/functionController.dart';
import 'package:mojtama/utils/themeModel.dart';
import 'package:mojtama/utils/util.dart';
import 'package:url_launcher/url_launcher_string.dart';

var box = Hive.box("theme");

class SettingsPage extends StatelessWidget {
  @override
  @override
  ThemeController c = Get.put(ThemeController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تنظیمات",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 50,
              height: 50,
            ),
          ),
          Divider(
            indent: 8,
            endIndent: 8,
            height: 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(7),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text(
                "تم تیره: ",
                style: TextStyle(fontSize: 14, color: Get.theme.accentColor),
              ),
              leading: Icon(
                Icons.dark_mode,
              ),
              subtitle: !Get.isDarkMode
                  ? Text(
                      "برای کمتر آسیب دیدن چشم، توصیه می‌شود تم تیره را فعال کنید.")
                  : null,
              trailing: Checkbox(
                value: c.isDark,
                activeColor: Colors.green,
                onChanged: (x) {
                  c.changeTheme();
                  // SystemChrome.setSystemUIOverlayStyle(
                  //   SystemUiOverlayStyle.light,
                  // ); TODO after update flutter to 3.0
                },
              ),
              horizontalTitleGap: 2,
              onTap: () {
                c.changeTheme();
              },
            ),
          ),
          Divider(
            height: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text("راه ارتباطی با برنامه‌نویس در پیامرسان بله"),
              subtitle: Text(
                  "اطلاعات کامل سفارش خود را به پیوی ارسال نمایید. (با فشردن این قسمت وارد محیط برنامه بله شوید.)"),
              onTap: () {
                launchUrlString("http://ble.im/JohnPeterson",
                    mode: LaunchMode.externalNonBrowserApplication);
              },
            ),
          ),
          Divider(
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

class LDMode extends StatefulWidget {
  @override
  _LDModeState createState() => _LDModeState();
}

class _LDModeState extends State<LDMode> {
  @override
  ThemeController c = Get.put(ThemeController());
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("تم تیره: "),
        Checkbox(
          value: c.isDark,
          activeColor: Colors.green,
          onChanged: (x) {
            setState(() => c.changeTheme);
          },
        )
      ],
    );
  }
}

class UpdateApp extends StatelessWidget {
  @override
  UserAPI userapi = UserAPI();
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userapi.checkApplicationVersion(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data["status"] == "updated") {
            return Container(
              child: TextButton(
                child: Text("نسخه اپلیکیشن شما بروز می‌باشد."),
                onPressed: () {},
              ),
            );
          } else if (snapshot.data["status"] == "not updated") {
            return Container(
              child: TextButton(
                child: Text("نسخه‌ی اپلیکیشن شما: " +
                    snapshot.data["version"] +
                    ". (برای دانلود، ضربه بزنید)"),
                onPressed: () {
                  launchUrlString(snapshot.data["link"],
                      mode: LaunchMode.externalApplication);
                },
              ),
            );
          }
        } else {
          return SpinKitChasingDots(
            color: Theme.of(context).accentColor,
            size: 50,
          );
        }
        return Container();
      },
    );
  }
}
