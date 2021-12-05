import 'package:flutter/material.dart';
import 'package:mojtama/utils/util.dart';
import 'package:get/get.dart';

class PrivilagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = false.obs;

    var controller2 = false.obs;
    var is_admin = false.obs;
    TextEditingController usernameTxt = TextEditingController();
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
                controller: usernameTxt,
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
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text("مدیر بلوک: "),
                  Obx(
                    () => Checkbox(
                      value: controller.value,
                      onChanged: (changed) {
                        controller.value = changed;
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
        child: Icon(Icons.save),
        tooltip: "تغییر",
      ),
    );
  }
}
