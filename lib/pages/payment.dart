import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پرداخت شارژ",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: PaymentLaunchUrl(),
                ),
              ),
            );
          },
          child: Text("پرداخت شارژ"),
        ),
      ),
    );
  }
}

class PaymentLaunchUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("theme");
    PaymentController c = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "بازکردن مرورگر و پرداخت",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        leading: IconButton(
          color: !box.get("is_dark") ? Colors.blue : Colors.amber,
          icon: Icon(Icons.arrow_back),
          tooltip: "برگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("ورود به درگاه پرداخت"),
          onPressed: () async {
            await launch(c.url);
          },
        ),
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
