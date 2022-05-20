import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/Admin/change_month.dart';
import 'package:mojtama/pages/customPayment.dart';
import 'package:mojtama/pages/customPayment2.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/widgets.dart';
import 'package:mojtama/widgets/yearsDrop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:mojtama/widgets/monthCheckBox.dart';

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
          // Padding(
          //   padding: EdgeInsets.all(30),
          //   child: TextFormField(
          //     autofocus: false,
          //     cursorColor: Colors.blue,
          //     keyboardType: TextInputType.number,
          //     cursorWidth: 1.2,
          //     textAlign: TextAlign.right,
          //     style: TextStyleX.style,
          //     controller: customizeTxt.value,
          //     onChanged: (string) {
          //       if (string == "") {
          //         has_val1.value = false;
          //       } else {
          //         has_val1.value = true;
          //       }
          //       print(has_val1);
          //     },
          //     decoration: InputDecoration(
          //       suffixIcon: Icon(Icons.monetization_on),
          //       //hintText: "نام کاربری خود را وارد کنید",
          //       labelStyle: TextStyleX.style,
          //       labelText: "مقدار مبلغ شارژ قبلی را وارد کنید.",
          //       helperText:
          //           "نکته: اگر این فیلد خالی باشد، شارژ این ماه حساب می‌شود.\nمی‌توانید چند شارژ را همزمان حساب کرده و مبلغ آن را وارد نمایید.\nمبلغ را به تومان وارد کنید.",
          //       helperMaxLines: 4,

          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //   ),
          // ),
          //it may be used in the future but now, it's not used.
          Obx(
            () => has_val1.value
                ? FadeIn(
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
                ? FadeIn(
                    child: MonthCheckBoxes(),
                    duration: Duration(milliseconds: 500),
                  )
                : Container(),
          ),
          Obx(
            () => has_val1.value
                ? FadeIn(
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
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // return Text("شارژ: ${snapshot.data}");
                    var data = jsonDecode(snapshot.data);
                    print(data[0]);
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
                    return Text("مشکلی پیش آمد." + snapshot.data.toString());
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
                        var url;
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
                        launch(url);
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
                    MaterialPageRoute(builder: (cnx) => CustomPayment()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextButton(
              child: Text("پرداخت شارژ ماه قبل و این ماه"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cnx) => CustomedPayment2(),
                  ),
                );
              },
            ),
          )
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