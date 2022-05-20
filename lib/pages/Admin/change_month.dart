import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/utils/util.dart';

var val = 0.obs;

class ChangeMonth extends StatelessWidget {
  @override
  var months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].obs;
  var months_farsi = [
    "محرم",
    "صفر",
    "ربیع الاول",
    "ربیع الثانی",
    "جمادی الاول",
    "جمادی الثانی",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذی القعده",
    "ذی الحجه",
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تغییر ماه شارژ",
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: List.generate(
            12,
            (index) {
              return MyRadioButton(
                value: index.obs + 1,
                titles: months_farsi,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        tooltip: "اعمال ماه شارژ",
        onPressed: () async {
          var ans = await Functions.updateMonth(months_farsi[val.value - 1]);
          var jsonDec = jsonDecode(ans);
          Get.snackbar("وضعیت", "${jsonDec["result"]}");
        },
      ),
    );
  }
}

class MyRadioButton extends StatelessWidget {
  RxInt value;
  List titles;
  MyRadioButton({this.value, this.titles});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
        child: Obx(
          () => RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            value: value.value,
            groupValue: val.value,
            activeColor: Theme.of(context).accentColor,
            title: Text(titles[value.value - 1]),
            onChanged: (changedVal) {
              val.value = changedVal;
              print("changed: $val");
            },
          ),
        ));
  }
}
