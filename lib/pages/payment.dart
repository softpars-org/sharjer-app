import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';

class PaymentPage extends StatelessWidget {
  @override
  Rx<TextEditingController> customizeTxt = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  var has_val1 = false.obs;
  var has_val2 = false.obs;

  Widget build(BuildContext context) {
    Future<String> charge_update() async {
      return await Functions.getPrice();
    }

    updateButton() {
      RxBool sth = true.obs; //a var for returning boolean.
      if (customizeTxt.value.text == "" && description.value.text != "") {
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: TextFormField(
              autofocus: false,
              cursorColor: Colors.blue,
              keyboardType: TextInputType.number,
              cursorWidth: 1.2,
              textAlign: TextAlign.right,
              style: TextStyleX.style,
              controller: customizeTxt.value,
              onChanged: (string) {
                if (string == "") {
                  has_val1.value = false;
                } else {
                  has_val1.value = true;
                }
                print(has_val1);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.monetization_on),
                //hintText: "نام کاربری خود را وارد کنید",
                labelStyle: TextStyleX.style,
                labelText: "مقدار مبلغ شارژ قبلی را وارد کنید.",
                helperText:
                    "نکته: اگر این فیلد خالی باشد، شارژ این ماه حساب می‌شود.\nمی‌توانید چند شارژ را همزمان حساب کرده و مبلغ آن را وارد نمایید.\nمبلغ را به تومان وارد کنید.",
                helperMaxLines: 4,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
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
                        controller: description.value,
                        decoration: InputDecoration(
                          //hintText: "نام کاربری خود را وارد کنید",
                          labelStyle: TextStyleX.style,
                          labelText: "توضیحات شارژ را وارد کنید.",
                          helperText: "برای مثال: شارژ بهمن ۱۴۰۰",
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
          Padding(
            padding: EdgeInsets.all(30),
            child: FutureBuilder(
              future: charge_update(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text("شارژ: ${snapshot.data}");
                  } else {
                    return Text("مشکلی پیش آمد.");
                  }
                } else {
                  return SpinKitChasingDots(
                    color: Theme.of(context).accentColor,
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
                    : () {}, //check if the first field has value & the second field don't have value, then button will turn off
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
          )
        ],
      ),
    );
  }
}

class PaymentController extends GetxController {
  String url = "https://mojtama.new-learn.ir/payment/simpleRequest.php";
  Future<String> getUrl() async {
    Uri url =
        Uri.parse("https://mojtama.new-learn.ir/payment/simpleRequest.php");
    http.Response req = await http.post(url);
    Map response = json.decode(req.body).obs;
    return response["url"];
  }
}
