import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatelessWidget {
  @override
  TextEditingController customizeTxt = TextEditingController();
  Widget build(BuildContext context) {
    Future<String> charge_update() async {
      return await Functions.getPrice();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پرداخت شارژ",
          style: Get.theme.primaryTextTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: TextFormField(
              autofocus: false,
              cursorColor: Colors.blue,
              cursorWidth: 1.2,
              textAlign: TextAlign.right,
              style: TextStyleX.style,
              controller: customizeTxt,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.monetization_on),
                //hintText: "نام کاربری خود را وارد کنید",
                labelStyle: TextStyleX.style,
                labelText: "مقدار مبلغ شخصی‌سازی شده را وارد کنید.",
                helperText:
                    "نکته: اگر این فیلد خالی باشد، شارژ این ماه حساب می‌شود.",
                helperMaxLines: 4,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: FutureBuilder(
              future:
                  Future.delayed(Duration(seconds: 2), () => charge_update()),
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
            child: ElevatedButton(
              clipBehavior: Clip.antiAlias,
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Text("گرفتن مبلغ شارژ فعلی"),
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
