import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:mojtama/utils/util.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class SignUpPage extends StatelessWidget {
  @override
  var checkValue = false.obs;
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController nameTxt = TextEditingController();
  TextEditingController familyTxt = TextEditingController();
  TextEditingController bluckTxt = TextEditingController();
  TextEditingController vahedTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  TextEditingController repassTxt = TextEditingController();
  FocusNode nameF = FocusNode();
  FocusNode familyF = FocusNode();
  FocusNode bluckF = FocusNode();
  FocusNode vahedF = FocusNode();
  FocusNode phoneF = FocusNode();
  FocusNode passF = FocusNode();
  FocusNode repassF = FocusNode();
  var isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    void checkChanged(bool value) {
      checkValue.value = value;
    }

    var box = Hive.box("theme");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "صفحه ثبت نام",
          style: Get.theme.primaryTextTheme.headline6,
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
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.left,
                style: TextStyleX.style,
                controller: usernameTxt,
                onSubmitted: (S) {
                  nameF.requestFocus();
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    labelStyle: TextStyleX.style,
                    labelText: "نام کاربری را وارد کنید",
                    helperText: "لطفا نام کاربری را به لاتین وارد کنید",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                focusNode: nameF,
                controller: nameTxt,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.right,
                style: TextStyleX.style,
                onSubmitted: (S) {
                  familyF.requestFocus();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.info),
                  labelStyle: TextStyleX.style,
                  labelText: "نام خود را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                focusNode: familyF,
                controller: familyTxt,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.right,
                onSubmitted: (S) {
                  bluckF.requestFocus();
                },
                style: TextStyleX.style,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.info),
                  labelStyle: TextStyleX.style,
                  labelText: "نام خانوادگی خود را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                focusNode: bluckF,
                controller: bluckTxt,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.right,
                onSubmitted: (S) {
                  vahedF.requestFocus();
                },
                keyboardType: TextInputType.number,
                style: TextStyleX.style,
                maxLength: 1,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.info),
                  labelStyle: TextStyleX.style,
                  labelText: "بلوک خود را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                focusNode: vahedF,
                controller: vahedTxt,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.right,
                onSubmitted: (S) {
                  phoneF.requestFocus();
                },
                keyboardType: TextInputType.number,
                style: TextStyleX.style,
                maxLength: 2,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.info),
                  labelStyle: TextStyleX.style,
                  labelText: "واحد خود را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                autofocus: false,
                focusNode: phoneF,
                controller: phoneTxt,
                cursorColor: Colors.blue,
                cursorWidth: 1.2,
                textAlign: TextAlign.left,
                style: TextStyleX.style,
                keyboardType: TextInputType.phone,
                onSubmitted: (S) {
                  passF.requestFocus();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  labelStyle: TextStyleX.style,
                  labelText: "شماره تلفن خود را وارد کنید",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  helperText: "مثلا 09384260524",
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.all(30),
                child: TextField(
                  autofocus: false,
                  focusNode: passF,
                  controller: passTxt,
                  cursorColor: Colors.blue,
                  cursorWidth: 1.2,
                  textAlign: TextAlign.left,
                  style: TextStyleX.style,
                  obscureText: !checkValue.value,
                  textDirection: TextDirection.ltr,
                  onSubmitted: (S) {
                    repassF.requestFocus();
                  },
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.lock_rounded),
                    //hintText: "گذرواژه خود را وارد کنید",
                    labelStyle: TextStyleX.style,
                    labelText: "گذرواژه را وارد کنید",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.all(30),
                child: TextField(
                  autofocus: false,
                  focusNode: repassF,
                  controller: repassTxt,
                  cursorColor: Colors.blue,
                  cursorWidth: 1.2,
                  textAlign: TextAlign.left,
                  style: TextStyleX.style,
                  obscureText: !checkValue.value,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.lock_rounded),
                    //hintText: "گذرواژه خود را وارد کنید",
                    labelStyle: TextStyleX.style,
                    labelText: "گذرواژه را مجددا وارد کنید",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                child: CheckboxListTile(
                  value: checkValue.value,
                  activeColor: Colors.green,
                  onChanged: checkChanged,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: Text(
                    "نمایش گذرواژه: ",
                    style: TextStyleX.style,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
                height: 60,
                child: OutlinedButton(
                  onPressed: () async {
                    final validate = await Functions.validate(
                      nameTxt.text,
                      familyTxt.text,
                      usernameTxt.text,
                      passTxt.text,
                      repassTxt.text,
                      vahedTxt.text,
                      bluckTxt.text,
                      phoneTxt.text,
                      context,
                    );
                    if (validate == -1) {
                      return;
                    }
                    isLoading.value = true;
                    final signUp = await Functions.signUp(
                      usernameTxt.text,
                      passTxt.text,
                      phoneTxt.text,
                      bluckTxt.text,
                      vahedTxt.text,
                      nameTxt.text,
                      familyTxt.text,
                      context,
                    );
                    isLoading.value = false;

                    // final Functions
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
                  child: Obx(
                    () => isLoading.value
                        ? SpinKitChasingDots(
                            size: 20, color: Theme.of(context).accentColor)
                        : Text(
                            "ثبت نام",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("حساب کاربری دارید؟ ورود",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//TODO: it has to be changed because it has a dirty UI...
// it has to be more convenient :) (hope i wrote it correctly lol XD) 