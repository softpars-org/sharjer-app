import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/utils/util.dart';

class ChangeShargePrice extends StatelessWidget {
  @override
  Rx<TextEditingController> shargeAmount = TextEditingController().obs;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تغییر میزان شارژ",
          style: Get.theme.primaryTextTheme.headline6,
        ),
        leading: IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.arrow_back),
          tooltip: "برگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: TextFormField(
          autofocus: false,
          cursorColor: Colors.blue,
          cursorWidth: 1.2,
          textAlign: TextAlign.left,
          style: TextStyleX.style,
          controller: shargeAmount.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.person),
            //hintText: "نام کاربری خود را وارد کنید",
            labelStyle: TextStyleX.style,
            labelText: "مبلغ جدید شارژ را وارد کنید",
            helperMaxLines: 3,
            helperText: "مبلغ را به تومان وارد کنید.",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () {
          Functions.changePrice(
            Hive.box("auth").get("username"),
            Hive.box("auth").get("password"),
            shargeAmount.value.text,
          );
        },
      ),
    );
  }
}
