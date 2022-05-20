import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/widgets/widgets.dart';
import 'package:mojtama/widgets/customedButton.dart';
import 'package:mojtama/widgets/customTextField.dart';
// import 'package:hive/hive.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController name =
      TextEditingController(text: Hive.box("auth").get('name'));
  TextEditingController family =
      TextEditingController(text: Hive.box("auth").get("family"));
  TextEditingController username =
      TextEditingController(text: Hive.box("auth").get("username"));
  TextEditingController phone =
      TextEditingController(text: Hive.box("auth").get("phone"));
  TextEditingController bluck =
      TextEditingController(text: Hive.box("auth").get("bluck"));
  TextEditingController vahed =
      TextEditingController(text: Hive.box("auth").get("vahed"));
  TextEditingController startdate = TextEditingController(
      text: Hive.box("auth").get("startdate") == ""
          ? "**/**/**"
          : Hive.box("auth").get("startdate"));
  TextEditingController enddate = TextEditingController(
      text: Hive.box("auth").get("enddate") == ""
          ? "**/**/**"
          : Hive.box("auth").get("enddate"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پروفایل من",
          style: Get.theme.primaryTextTheme.headline6,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          label: "نام من",
                          style: TextStyleX.style,
                          icon: Icon(Icons.person),
                          controller: name,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.person),
                          label: "نام خانوادگی من",
                          style: TextStyleX.style,
                          controller: family,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.perm_identity),
                          label: "نام کاربری من",
                          style: TextStyleX.style,
                          controller: username,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.phone),
                          label: "شماره موبایل من",
                          style: TextStyleX.style,
                          controller: phone,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.domain),
                          label: "بلوک من",
                          style: TextStyleX.style,
                          controller: bluck,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.account_balance),
                          label: "واحد من",
                          style: TextStyleX.style,
                          controller: vahed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.date_range_outlined),
                          label: "تاریخ ورود",
                          style: TextStyleX.style,
                          controller: startdate,
                          helper: "به صورت شمسی وارد شود: ۱۴۰۰/۲/۲",
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomedTextField(
                          icon: Icon(Icons.date_range_outlined),
                          label: "تاریخ خروج",
                          style: TextStyleX.style,
                          controller: enddate,
                          helper: "به صورت شمسی وارد شود: ۱۴۰۰/۲/۲",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(60),
            child: CustomedButton(
              child: Text("آپدیت پروفایل"),
              padding: EdgeInsets.all(30),
              onPressed: () async {
                // print(DateTime.now().toIso8601String());
                print(phone.text);
                var res = await Functions.updateProfile(
                  username.text,
                  name.text,
                  family.text,
                  phone.text,
                  bluck.text,
                  vahed.text,
                  startdate.text,
                  enddate.text,
                );
                var js = jsonDecode(res);
                var box = Hive.box("auth");
                if (js["status"] == "ok") {
                  box.put("username", username.text);
                  box.put("name", name.text);
                  box.put("family", family.text);
                  box.put("phone", phone.text);
                  box.put("bluck", bluck.text);
                  box.put("vahed", vahed.text);
                  box.put("startdate", startdate.text);
                  box.put("enddate", enddate.text);
                }
                Get.snackbar(
                  "وضعیت",
                  jsonDecode(res)["result"],
                );
              },
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(30),
          //   child: TextButton(
          //     onPressed: () {},
          //     child: Text("تعویض رمز عبور"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
