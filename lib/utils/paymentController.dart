import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mojtama/utils/util.dart';

class PaymentController extends GetxController {
  //initial vars.
  Rx<TextEditingController> customizeTxt = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  List months = [];
  RxString year = "1443".obs;
  RxString year2 = "".obs;
  RxInt groupValue = 0.obs;
  var moharam = false.obs;
  var safar = false.obs;
  var rabiol1 = false.obs;
  var rabiol2 = false.obs;
  var jamadi1 = false.obs;
  var jamadi2 = false.obs;
  var rajab = false.obs;
  var shaban = false.obs;
  var ramezan = false.obs;
  var shaval = false.obs;
  var zighade = false.obs;
  var zilhaje = false.obs;
  RxList ymd = [].obs; //means year month description.
  ///////////// functions.
  getUrl() async {
    String? username = Hive.box("auth").get("username");
    String month = await Functions.getCurrentMonthCharge();
    String year = await Functions.getYear();
    String url =
        "http://localhost/mojtama/src/payment/simpleRequest.php?username=$username&month=$month&year=$year";
    Uri uri = Uri.parse(url);
    http.Response req = await http.post(uri);
    Map response = json.decode(req.body);
    return response["url"];
  }

  getCustomUrl(data) async {
    //this function gets a valid url from zibal which is customized by the user's price.
    String? username = Hive.box("auth").get("username");
    Uri url =
        Uri.parse("http://localhost/mojtama/src/payment/customRequest.php");
    var payload = {
      "username": username,
      "json": data,
    };
    print(data);

    //print(payload);
    var req = await http.post(url, body: payload);
    var js;
    try {
      js = json.decode(req.body);
    } catch (e) {
      Get.snackbar(
        "وضعیت",
        "خروجی نامعتبر است.",
      );
    }

    print(req.body);
    if (js["message"] == "amount<100 IRR") {
      Get.snackbar(
        "وضعیت",
        "قیمت را کمتر از ۱۰۰۰ ریال وارد کرده‌اید.",
      );
    } else if (js["message"] == "success") {
      return js["url"];
    }
  }
}
