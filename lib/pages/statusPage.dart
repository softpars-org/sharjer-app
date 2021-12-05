import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StatusPageUser extends StatelessWidget {
  @override
  var box1 = Hive.box("auth");
  var box2 = Hive.box("theme");
  List response = [];
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
      body: ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 100,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  response[index].toString(),
                ),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );

    // body: ListView(
    //     children: [
    //       Container(
    //         padding: EdgeInsets.all(50),
    //         //color: Colors.red,
    //         margin: EdgeInsets.all(10),
    //         child: CircularPercentIndicator(
    //           radius: 130,
    //           lineWidth: 11,
    //           animation: true,
    //           percent: 70 / 100,
    //           progressColor: Theme.of(context).accentColor,
    //           circularStrokeCap: CircularStrokeCap.round,
    //           center: Text(),
    //         ),
    //       )
    //     ],
    //   ),

    //),
  }
}
