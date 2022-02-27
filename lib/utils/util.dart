import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/pages/dashboard.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';

import '../main.dart';

class TextStyleX {
  static const style = TextStyle(
    fontFamily: 'Vazir',
    fontSize: 14,
  );
  static var appBarStyle = TextStyle(
    fontWeight: FontWeight.w300,
    color: Hive.box("theme").get("is_dark") ? Colors.amber : Colors.blue,
  );
}

class DrawerX {
  static const drawer = Drawer();
}

class ThemeX {
  static bool is_dark = false;
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    primaryColorDark: Color(0xFFFEA82F),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
    ),
    accentIconTheme: IconThemeData(
      color: Colors.blue,
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
    ),
    fontFamily: 'Vazir',
    buttonColor: Colors.blue,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.amber),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    ),
    brightness: Brightness.light,
    canvasColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.amber[800],
    primarySwatch: Colors.amber,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 5.0,
      centerTitle: true,
    ),
    accentIconTheme: IconThemeData(
      color: Colors.amber,
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.amber, fontWeight: FontWeight.w300),
    ),
    primaryColorDark: Colors.black,
    fontFamily: 'Vazir',
    accentTextTheme: TextTheme(bodyText1: TextStyle(fontSize: 14)),
    buttonColor: Colors.amber[800],
    dividerColor: Colors.grey,
    textTheme: TextTheme(button: TextStyle(fontSize: 14)),
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    accentColor: Colors.amber,
    shadowColor: Colors.grey,
    hoverColor: Colors.grey[800].withOpacity(0.6),
  );
}

class Functions extends GetxController {
  var box = Hive.box("user");
  void put(key, value) {
    box.put(key, value);
  }

  static getUsersList() async {
    var username = Hive.box("auth").get("username");
    var password = Hive.box("auth").get("password");
    Map payload = {"username": username, "password": password};
    Uri url = Uri.parse(
        "http://192.168.1.102/mojtama/sources/adminpanel/get_members_list.php");
    http.Response req = await http.post(url, body: payload);
    var js;
    try {
      js = jsonDecode(req.body);
    } catch (e) {
      Get.snackbar(
        "وضعیت",
        "خروجی نامعتبر است...",
      );
    }
    return js;
  }

  static changePrivilege(
      String username, String password, String target, String privilege) async {
    Map payload = {
      "username": username,
      "password": password,
      "target": target,
      "privilege": privilege
    };
    var uri = Uri.parse(
        "http://192.168.1.102/mojtama/sources/adminpanel/change_priv.php");

    http.Response req;
    try {
      req = await http.post(uri, body: payload);
    } catch (e) {
      Get.snackbar("وضعیت", "خطا در برقراری ارتباط با سرور");
    }

    return req.body;
  }

  static loginS(String username, String password, BuildContext context) async {
    Uri url =
        Uri.parse("http://192.168.1.102/mojtama/sources/userapi/login.php");
    Map payload = {"username": username, "password": password};
    http.Response res;
    try {
      res = await http.post(url, body: payload);
      Map ans = json.decode(res.body);
      print(ans);
      if (ans["status"]["password"] == "false") {
        // showTopSnackBar(
        //   context,
        //   CustomSnackBar.error(
        //     message: "گذرواژه و یا نام کاربری شما نادرست میباشد",
        //   ),
        // );
        ///////////////////////////// this is for past...
        Get.snackbar(
          "وضعیت",
          "گذرواژه و یا نام کاربری شما نادرست میباشد",
        );
      } else {
        // showTopSnackBar(
        //   context,
        //   CustomSnackBar.success(
        //     message: "ورود شما با موفقیت انجام شد",
        //   ),
        // );
        ///////////////////////////// this is for past...

        Digest hash = md5.convert(utf8.encode(password));
        var box = Hive.box("auth");

        box.put("username", username);
        box.put("password", hash.toString());
        box.put("name", ans["status"]["name"]);
        box.put("family", ans["status"]["family"]);
        box.put("passlen", password.length);
        box.put("is_admin", ans["status"]["is_admin"]);
        print("ans is: ${ans["status"]["is_admin"]}");
        box.put("is_loggined", true);

        Get.offNamed("/home");
        Get.snackbar(
          "وضعیت",
          "${ans["status"]["name"]} ${ans["status"]["family"]} " +
              "عزیز، به اپلیکیشن مجتمع آملی خوش آمدید!",
        );
        print(box.get("name"));
        print(ans);
      }
    } catch (e) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "خطا در برقراری ارتباط با سرور",
      //   ),
      // );
      ///////////////////////////// this is for past...
      Get.snackbar(
        "وضعیت",
        "خطا در برقراری ارتباط با سرور",
      );
      print(res.body);
    }
  }

  static signUp(
    String username,
    String password,
    String phoneNumber,
    String bluck,
    String vahed,
    String name,
    String family,
    BuildContext context,
  ) async {
    Map payload = {
      "username": username,
      "password": password,
      "phone": phoneNumber,
      "bluck": bluck,
      "vahed": vahed,
      "name": name,
      "family": family,
    };

    Uri url =
        Uri.parse("http://192.168.1.102/mojtama/sources/userapi/signup.php");
    http.Response req = await http.post(url, body: payload);
    print(req.body.trim());
    Map response = json.decode(req.body.trim());
    if (response["info"] == "success") {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.success(
      //     message: response["message"],
      //   ),
      // );
      Get.snackbar(
        "وضعیت",
        response["message"],
      );
      Digest hash = md5.convert(utf8.encode(password));
      Digest hash2 = md5.convert(utf8.encode(hash.toString()));
      var box = Hive.box("auth");
      box.put("name", name);
      box.put("family", family);
      box.put("username", username);
      box.put("password", hash2.toString());
      box.put("passlen", password.length);
      box.put("is_admin", "false");
      box.put("is_loggined", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TabView(),
        ),
      );
    } else {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "خطا! " + response["message"],
      //   ),
      // );
      /////////////this is for past time.
      Get.snackbar(
        "وضعیت",
        "خطا! " + response["message"],
      );
    }
  }

  static validate(
    String name,
    String family,
    String username,
    String password,
    String repassword,
    String vahed,
    String bluck,
    String phone,
    BuildContext context,
  ) {
    if (name == "" ||
        family == "" ||
        username == "" ||
        password == "" ||
        repassword == "" ||
        vahed == "" ||
        bluck == '' ||
        phone == "") {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(message: "لطفا تمام فیلد ها را پر کنید"),
      // );
      //////////////this is for past
      Get.snackbar(
        "وضعیت",
        "لطفا تمام فیلد ها را پر کنید",
      );
      return -1;
    } else if (password != repassword) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message:
      //         "گذرواژه شما با هم مطابقت ندارد...\nلطفا آن را تصحیح نمایید.",
      //   ),
      // );
      Get.snackbar(
        "وضعیت",
        "گذرواژه شما با هم مطابقت ندارد...\nلطفا آن را تصحیح نمایید.",
      );
      return -1;
    } else if (password.length < 4) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "گذرواژه نمیتواند کمتر از ۴ کاراکتر باشد",
      //   ),
      // );
      /////////this is for past
      Get.snackbar(
        "وضعیت",
        "گذرواژه نمیتواند کمتر از ۴ کاراکتر باشد",
      );
      return -1;
    } else if ((int.tryParse(vahed) != null ? int.parse(vahed) : 5) > 20) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "لطفا واحد خود را تصحیح نمایید(هر بلوک ۲۰ واحد دارد)",
      //   ),
      // );
      /////////////this is for past
      Get.snackbar(
        "وضعیت",
        "گذرواژه نمیتواند کمتر از ۴ کاراکتر باشد",
      );
      return -1;
    } else if ((int.tryParse(bluck) != null ? int.parse(bluck) : 5) > 3) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "لطفا بلوک خود را تصحیح نمایید",
      //   ),
      // );
      Get.snackbar(
        "وضعیت",
        "لطفا بلوک خود را تصحیح نمایید",
      );
      return -1;
    } else if (phone.length != 11 || !phone.contains("09")) {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "الگوی شماره تلفن شما درست نمیباشد",
      //   ),
      // );
      Get.snackbar(
        "وضعیت",
        "الگوی شماره تلفن شما درست نمیباشد",
      );
      return -1;
    }
  }

  static changePrice(username, password, price) async {
    Map payload = {"username": username, "password": password, "price": price};

    Uri url = Uri.parse(
        "http://192.168.1.102/mojtama/sources/adminpanel/change_price.php");
    final req = await http.post(url, body: payload);
    var js = jsonDecode(req.body);
    print(js);
    if (!js["status"]) {
      Get.snackbar(
        "وضعیت",
        "خطایی پیش آمد.",
      );
    } else {
      Get.snackbar(
        "وضعیت",
        "عملیات تغییر مبلغ شارژ با موفقیت انجام شد.",
      );
    }
  }

  static getPrice() async {
    //TODO: I SHOULD WRITE SOMETHING HERE!!!!!!!!
    var url =
        Uri.parse("http://localhost/mojtama/sources/userapi/get_price.php");
    var request = await http.get(url);

    return request.body.toString();
  }
}

//TODO: i'm here. i'm gonna code indicating charge of members of complex.
