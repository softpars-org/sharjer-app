import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mojtama/utils/themeModel.dart';
import 'package:mojtama/utils/util.dart';

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
          )
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

// class Controller extends GetxController {
//   var box = Hive.box("theme");
//   bool? is_darkMode = Hive.box("theme").get("is_dark");
//   late var bvalue;

//   box_value() {
//     bvalue.value = is_darkMode;
//   }

//   changeThemeCheckbox(x) {
//     is_darkMode = x;
//     box.put("is_dark", x);
//     Get.changeThemeMode(box.get("is_dark") ? ThemeMode.dark : ThemeMode.light);
//   }

//   changeThemeAlert() {
//     box.put("is_dark", !box.get("is_dark"));
//     Get.changeThemeMode(box.get("is_dark") ? ThemeMode.dark : ThemeMode.light);
//     is_darkMode = box.get("is_dark");
//   }
// }
