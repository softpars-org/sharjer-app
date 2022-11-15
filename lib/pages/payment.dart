import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:mojtama/pages/customPayment.dart';
import 'package:mojtama/pages/customPayment2.dart';
import 'package:mojtama/utils/paymentController.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/customedButton.dart';

import 'package:mojtama/widgets/yearsDrop.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:animate_do/animate_do.dart';
import 'package:mojtama/widgets/monthCheckBox.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentPage extends StatelessWidget {
  @override
  var has_val1 = false.obs;
  var has_val2 = false.obs;

  Widget build(BuildContext context) {
    PaymentController controller = Get.put(PaymentController());
    Future<String> charge_update() async {
      var price = await Functions.getPrice();
      var month = await Functions.getCurrentMonthCharge();
      var lst = [price, month];
      return jsonEncode(lst);
    }

    updateButton() {
      RxBool sth = true.obs; //a var for returning boolean.
      if (controller.customizeTxt.value.text == "" &&
          controller.description.value.text != "") {
        sth.value = true;
      } else {
        sth.value = false;
      }
      return sth;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پرداخت شارژ",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),
      body: ListView(
        children: [
          CustomedButton(
            margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
            //padding: EdgeInsets.all(10),
            child: Text("بروزرسانی شارژ"),
            onPressed: () {
              Get.forceAppUpdate();
            },
          ),
          Obx(
            () => has_val1.value
                ? AnimatedOpacity(
                    opacity: has_val1.value ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 5,
                        onChanged: (string) {
                          if (string == "") {
                            has_val2.value = false;
                          } else {
                            has_val2.value = true;
                          }
                        },
                        autofocus: false,
                        cursorColor: Colors.blue,
                        cursorWidth: 1.2,
                        textAlign: TextAlign.right,
                        style: TextStyleX.style,
                        controller: controller.description.value,
                        decoration: InputDecoration(
                          //hintText: "نام کاربری خود را وارد کنید",
                          labelStyle: TextStyleX.style,
                          labelText: "توضیحات شارژ را وارد کنید.",
                          helperText:
                              "برای مثال: شارژ رمضان و شوال ۱۴۴۳ به دلیل ... در وقت مقرر پرداخت نشد.",
                          helperMaxLines: 4,
                          alignLabelWithHint: true,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
          Obx(
            () => has_val1.value
                ? AnimatedOpacity(
                    opacity: has_val1.value ? 1 : 0,
                    child: MonthCheckBoxes(),
                    duration: Duration(milliseconds: 500),
                  )
                : Container(),
          ),
          Obx(
            () => has_val1.value
                ? AnimatedOpacity(
                    opacity: has_val1.value ? 1 : 0,
                    child: YearsDropDownButton(),
                    duration: Duration(milliseconds: 500),
                  )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: FutureBuilder(
              future: charge_update(),
              // ignore: missing_return
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // return Text("شارژ: ${snapshot.data}");
                    var data = jsonDecode(snapshot.data);
                    return Column(
                      children: [
                        Text(
                          "شارژ ماه " + data[1].toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          data[0].toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("مشکلی پیش آمد.");
                  }
                } else {
                  return SpinKitChasingDots(
                    color: Theme.of(context).accentColor,
                    size: 35,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Obx(
              () => OutlinedButton(
                onPressed: (has_val1.value == true && has_val2.value == false)
                    ? null
                    : () async {
                        late var url;
                        if (has_val1.value) {
                          print(controller.year);
                          print(controller.months);
                          // url = await controller.getCustomUrl(
                          //     controller.description.value.text,
                          //     controller.year.value,
                          //     jsonEncode(controller.months));
                        } else {
                          url = await controller.getUrl();
                        }
                        launchUrlString(url,
                            mode: LaunchMode.externalApplication);
                      }, //check if the first field has value & the second field don't have value, then button will turn off
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                ),
                child: Text("پرداخت شارژ"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextButton(
              child: Text("پرداخت شارژ معوقه"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (cnx) => CustomedPayment2()));
              },
            ),
          ),
        ],
      ),
    );
  }
}


// Navigator.pushAndRemoveUntil(
//   context,
//   MaterialPageRoute(builder: (context) => MainPage()),
//   (Route<dynamic> route) => false,
// );
//REFRESH PAGE IMPLEMENTATION.