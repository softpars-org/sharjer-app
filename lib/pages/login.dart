import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/main.dart';
import 'package:mojtama/pages/signup.dart';
import 'package:mojtama/widgets/widgets.dart';
import '../utils/util.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mojtama/widgets/customTextField.dart';

class LoginPage extends StatelessWidget {
  var checkValue = false.obs;
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void checkChanged(bool? value) {
      checkValue.value = value!;
    }

    var isLoading = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "صفحه ورود",
          style: Get.theme.primaryTextTheme.headline6,
        ),
        leading: IconButton(
          tooltip: "تغییر تم",
          icon: Icon(Icons.brightness_4, color: Get.theme.accentColor),
          onPressed: () {
            // ignore: missing_return

            Hive.box("theme").put(
              "is_dark",
              !Hive.box("theme").get("is_dark"),
            );
            print(Hive.box("theme").get("is_dark"));
            Get.changeThemeMode(
              Hive.box("theme").get("is_dark")
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            // SizedBox(
            //   height: Get.height / 9,
            // ),
            Padding(
              padding: EdgeInsets.all(30),
              child: CustomedTextField(
                label: "نام کاربری خود را وارد کنید",
                style: TextStyle(fontFamily: 'Vazir', fontSize: 14),
                icon: Icon(Icons.person_outline),
                controller: usernameTxt,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30),
              //   child: TextFormField(
              //     autofocus: false,
              //     controller: passwordTxt,
              //     cursorColor: Colors.blue,
              //     cursorWidth: 1.2,
              //     textAlign: TextAlign.left,
              //     style: TextStyleX.style,
              //     obscureText: !checkValue.value,
              //     textDirection: TextDirection.ltr,
              //     decoration: InputDecoration(
              //       //prefixIcon: Icon(Icons.lock),
              //       suffixIcon: Icon(Icons.lock_rounded),
              //       //hintText: "گذرواژه خود را وارد کنید",
              //       labelStyle: TextStyleX.style,
              //       labelText: "گذرواژه خود را وارد کنید",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //   ),
              // ),
              child: Obx(
                () => CustomedTextField(
                  label: "گذرواژه خود را وارد کنید",
                  icon: Icon(Icons.lock_outline_rounded),
                  obscureText: !checkValue.value,
                  dir: TextDirection.ltr,
                  controller: passwordTxt,
                  style: TextStyle(fontFamily: 'Vazir', fontSize: 14),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                child: CheckboxListTile(
                  activeColor: Colors.green,
                  value: checkValue.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onChanged: checkChanged,
                  title: Text(
                    "نمایش گذرواژه",
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
                child: Obx(
                  () => OutlinedButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            if (usernameTxt.text == "" ||
                                passwordTxt.text == "") {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message: "لطفا فیلد ها را پر کنید",
                                ),
                              );
                            } else {
                              isLoading.value = true;
                              final res = await Functions.loginS(
                                usernameTxt.text,
                                passwordTxt.text,
                                context,
                              );
                              isLoading.value = false;
                            }
                          },
                    //color: Colors.blue,

                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Obx(
                      () => isLoading.value
                          ? SpinKitChasingDots(
                              color: Hive.box("theme").get('is_dark')
                                  ? Colors.amber
                                  : Colors.blue,
                              size: 20,
                            )
                          : Text(
                              "ورود",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //     builder: (context) => Directionality(
                  //       textDirection: TextDirection.rtl,
                  //       child: SignUpPage(),
                  //     ),
                  //   ),
                  // );
                  Get.to(() => SignUpPage());
                },
                child: Text(
                  "حساب کاربری ندارید؟ ثبت نام",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
