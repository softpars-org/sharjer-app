import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/login.dart';
import 'package:mojtama/pages/profile.dart';
import 'package:mojtama/pages/settings.dart';
import 'package:mojtama/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:mojtama/widgets/customedButton.dart';
import 'adminScreens/admin_panel.dart';

class LogginedPage extends StatelessWidget {
  String? title;
  LogginedPage({this.title});
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   getadminstatus();
    // });
    Future<void> getadminstatus() async {
      Map data = {"username": Hive.box("auth").get("username")};

      http.Response req = await http.post(
        Uri.parse("http://192.168.1.101/mojtama/userapi/isAdmin.php"),
        body: data,
      );

      Hive.box("auth").put("is_admin", req.body.toString().trim());

      print(Hive.box("auth").get("username"));
      print(req.body.toString().trim());
    }

    String getPassLen() {
      var box = Hive.box("auth");
      int len = box.get("passlen");
      String starOfLen = "";
      for (int i = 0; i < len; i++) {
        starOfLen += "*";
      }
      return starOfLen;
    }

    bool is_admin() {
      var box = Hive.box("auth");
      if (box.get("is_admin") == "full") {
        return true;
      } else if (box.get("is_admin").contains("bluck")) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پیشخان",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Get.theme.primaryColor,
            size: 24,
          ),
          tooltip: "اعلان‌های ارسال شده",
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: Get.height / 7,
          ),
          Center(
            child: CustomedButton(
              child: Column(
                children: [
                  Icon(Icons.person_outline),
                  Text('پروفایل'),
                ],
              ),
              padding: EdgeInsets.all(30),
              onPressed: () => Navigator.of(context)
                  .push(GetPageRoute(page: () => ProfilePage())),
            ),
          ),
          is_admin()
              ? Center(
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 120,
                        right: 120,
                        top: 50,
                        bottom: 0,
                      ),
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            GetPageRoute(
                              page: () => AdminOptions(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.admin_panel_settings_outlined),
                            Text("مدیریت"),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 100,
                  right: 100,
                  top: 50,
                  bottom: 20,
                ),
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    var box = Hive.box("auth");
                    box.clear();

                    Get.offNamed("/login");
                    Get.snackbar(
                      "",
                      "",
                      titleText: Text(
                        "وضعیت:",
                        textDirection: TextDirection.rtl,
                      ),
                      messageText: Text(
                        "خارج شدید...",
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Icon(Icons.exit_to_app_rounded),
                        Text("خروج"),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
