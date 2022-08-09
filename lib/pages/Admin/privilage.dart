import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:get/get.dart';

class PrivilagePage extends StatelessWidget {
  @override
  var controller = 0.obs;

  var controller2 = false.obs;
  var controller3 = false.obs;
  var is_admin = false.obs;
  Rx<TextEditingController> usernameTxt = TextEditingController().obs;

  String? target;
  var choice = 0.obs;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تغییر دسترسی اعضا",
          style: Get.theme.primaryTextTheme.headline6,
        ),
        leading: IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.arrow_back),
          tooltip: "برگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                autofocus: false,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.left,
                style: TextStyleX.style,
                controller: usernameTxt.value,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  //hintText: "نام کاربری خود را وارد کنید",
                  labelStyle: TextStyleX.style,
                  labelText: "نام کاربری فرد مورد نظر را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Text("سطح دسترسی:"),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text("مدیر بلوک1: "),
                  Obx(
                    () => Radio(
                      activeColor: Get.theme.accentColor,
                      groupValue: choice.value,
                      value: 1,
                      onChanged: (dynamic changed) {
                        choice.value = changed;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text("مدیر بلوک2: "),
                  Obx(
                    () => Radio(
                      activeColor: Get.theme.accentColor,
                      groupValue: choice.value,
                      value: 2,
                      onChanged: (dynamic changed) {
                        choice.value = changed;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text("مدیر بلوک3: "),
                  Obx(
                    () => Radio(
                      activeColor: Get.theme.accentColor,
                      groupValue: choice.value,
                      value: 3,
                      onChanged: (dynamic changed) {
                        choice.value = changed;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        tooltip: "ذخیره",
        onPressed: () async {
          print(await Functions.changePrivilege(
              Hive.box("auth").get("username").toString(),
              Hive.box("auth").get("password"),
              usernameTxt.value.text,
              "no"));
        },
      ),
    );
  }
}
