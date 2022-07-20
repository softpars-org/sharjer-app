import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/customTextField.dart';
import 'package:mojtama/widgets/monthCheckBox.dart';
import 'package:mojtama/widgets/monthRadioBox.dart';
import 'package:mojtama/widgets/yearsDrop.dart';

class ChargeAdd extends StatelessWidget {
  @override
  PaymentController controller = Get.put(PaymentController());
  TextEditingController targetBluck = new TextEditingController();
  TextEditingController targetVahed = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضافه کردن شارژ(دستی)",
          style: TextStyle(color: Get.theme.accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Get.theme.accentColor,
          tooltip: "بازگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomedTextField(
                      label: "بلوک موردنظر",
                      icon: Icon(Icons.domain),
                      style: TextStyleX.style,
                      controller: targetBluck,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomedTextField(
                      label: "واحد موردنظر",
                      icon: Icon(Icons.account_balance),
                      style: TextStyleX.style,
                      controller: targetVahed,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: YearsDropDownButton(),
                  ),
                ),
              ],
            ),
            MonthRadioBoxes(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.accentColor,
        child: Icon(Icons.check),
        tooltip: "اضافه کردن شارژ به فرد",
        onPressed: () {
          Get.defaultDialog(
            title: "تاییدیه",
            middleText: "آیا مایلید شارژ را به کاربر اضافه کنید؟",
            textConfirm: "بله",
            textCancel: "خیر",
            onConfirm: () async {
              var myUser = Hive.box("auth").get("username");
              var password = Hive.box("auth").get("password");
              var targetYear = controller.year.value;
              var targetMonth = controller.groupValue.value.toString();
              if (targetBluck.text != "" && targetVahed.text != "") {
                var ans = await Functions.addCharge(
                  myUser,
                  password,
                  targetBluck.text,
                  targetVahed.text,
                  targetYear,
                  targetMonth,
                );
                if (ans == "true") {
                  Get.snackbar(
                    "وضعیت",
                    "با موفقیت شارژ به کاربر اختصاص داده شد.",
                  );
                } else {
                  Get.snackbar("وضعیت", "مشکلی بوجود آمد.");
                }
              } else {
                Get.snackbar("وضعیت", "فیلد‌ها را پر کنید.");
              }
            },
            onCancel: () {},
          );
        },
      ),
    );
  }
}
