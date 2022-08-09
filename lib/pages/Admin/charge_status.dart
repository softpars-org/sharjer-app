// ignore_for_file: missing_return

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:mojtama/widgets/yearTable.dart';

class StatusPageUser extends StatelessWidget {
  String? username;
  StatusPageUser({this.username});
  @override
  var box1 = Hive.box("auth");
  var box2 = Hive.box("theme");

  Widget build(BuildContext context) {
    var th = Get.theme.primaryTextTheme.headline6.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "وضعیت شارژ $username",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.theme.accentColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ignore: missing_return
      body: FutureBuilder(
        future: Functions.getUserCharge(username),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            if (snapshot.data[0] == null) {
              return Center(
                child: Text(
                    "تا کنون کاربر شارژی را توسط برنامه پرداخت نکرده‌است."),
              );
            } else if (snapshot.hasData && snapshot.data.toString() != "-1") {
              var json = jsonDecode(snapshot.data[0]);

              return ListView.builder(
                  itemCount: json.length,
                  itemBuilder: (context, index) {
                    return YearTable(
                      year: int.parse(snapshot.data[1]) - index, //gives year
                      json: json[index], //gives json response of charge info
                      name: snapshot.data[2],
                    );
                  });
            } else {
              return Center(
                child: Text(
                    "تا به حال شارژی پرداخت نکرده‌اید(و یا مشکلی در دریافت پیش آمده است.)"),
              );
            }
          } else {
            return SpinKitChasingDots(
              color: Theme.of(context).accentColor,
            );
          }
        },
      ),
    );
  }
}
