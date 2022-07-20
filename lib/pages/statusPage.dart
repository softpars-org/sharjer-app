// ignore_for_file: missing_return

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/customStatusPage.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/widgets.dart';
import 'package:mojtama/widgets/yearTable.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:mojtama/widgets/customedButton.dart';

class StatusPageUser extends StatelessWidget {
  @override
  var box1 = Hive.box("auth");
  var box2 = Hive.box("theme");
  Future<String> fetchShargeStatus() async {
    String username = box1.get("username");
    Map payload = {"username": username};
    Map headers = {"Content-Type": "application/json"};

    return "data";
  }

  Widget build(BuildContext context) {
    var th = Get.theme.primaryTextTheme.headline6.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "وضعیت شارژ شما",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),

      // ignore: missing_return
      body: Y(),
    );
  }
}

class Y extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Functions.getMyCharge(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data.toString() != "-1") {
            var json = jsonDecode(snapshot.data[0]);
            return ListView.builder(
              itemCount: json.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      CustomedButton(
                        child: Text("بروزرسانی صفحه"),
                        onPressed: () {
                          Get.forceAppUpdate();
                        },
                      ),
                      // as you see, i put a button above the Year table (at first) right? that's it ...
                      YearTable(
                        year: int.parse(snapshot.data[1]) - index, //gives year
                        json: json[index], //gives json response of charge info
                        name: Hive.box("auth").get("name") +
                            " " +
                            Hive.box("auth").get("family"),
                      ),
                    ],
                  );
                }
                return YearTable(
                  year: int.parse(snapshot.data[1]) - index, //gives year
                  json: json[index], //gives json response of charge info
                  name: Hive.box("auth").get("name") +
                      " " +
                      Hive.box("auth").get("family"),
                );
              },
            );
          } else {
            return Center(
                child: Text(
                    "تا به حال شارژی پرداخت نکرده‌اید(و یا مشکلی در دریافت پیش آمده است.)"));
          }
        } else {
          return SpinKitChasingDots(
            color: Theme.of(context).accentColor,
          );
        }
      },
    );
  }
}
