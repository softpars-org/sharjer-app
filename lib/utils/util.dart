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
  ThemeData ss = new ThemeData();

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
    dividerColor: Colors.grey.shade800,
    textTheme: TextTheme(button: TextStyle(fontSize: 14)),
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    accentColor: Colors.amber,
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.amber)),
    shadowColor: Colors.grey,
    hoverColor: Colors.grey[800].withOpacity(0.6),
  );
}

class Functions extends GetxController {
  var box = Hive.box("user");
  void put(key, value) {
    box.put(key, value);
  }

  //static String host = "https://www.amolicomplex.ir/src";
  static String host = "http://localhost/mojtama/src";
  static getUsersList() async {
    var username =
        Hive.box("auth").get("username"); //get username from hive database
    var password =
        Hive.box("auth").get("password"); //get password from hive database
    print(password);
    Map payload = {"username": username, "password": password};
    Uri url = Uri.parse("${host}/adminpanel/get_members_list.php");
    http.Response req = await http.post(url, body: payload);
    var js;
    try {
      js = jsonDecode(req.body);
    } catch (e) {
      Get.snackbar(
        "وضعیت",
        "خروجی دریافت شده نامعتبر می‌باشد.",
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
    var uri = Uri.parse("$host/adminpanel/change_priv.php");

    http.Response req;
    try {
      req = await http.post(uri, body: payload);
    } catch (e) {
      Get.snackbar("وضعیت", "خطا در برقراری ارتباط با سرور");
    }

    return jsonDecode(req.body);
  }

  static loginS(String username, String password, BuildContext context) async {
    Uri url = Uri.parse("$host/userapi/login.php");
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
        box.put("phone", ans["status"]["phone"]);
        box.put("bluck", ans["status"]["bluck"]);
        box.put("vahed", ans["status"]["vahed"]);
        box.put("is_admin", ans["status"]["is_admin"]);
        box.put("startdate", ans["status"]["startdate"]);
        box.put("enddate", ans["status"]["enddate"]);
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

    Uri url = Uri.parse("$host/userapi/signup.php");
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
      var box = Hive.box("auth");
      box.put("name", name);
      box.put("family", family);
      box.put("username", username);
      box.put("password", password.toString());
      box.put("passlen", password.length);
      box.put('vahed', vahed.toString());
      box.put('bluck', bluck.toString());
      box.put("phone", phoneNumber.toString());
      box.put("is_admin", "false");
      box.put("is_loggined", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TabView(),
        ),
      );
      Get.snackbar(
        "وضعیت",
        "${box.get('name')} ${box.get('family')} " +
            "عزیز، به اپلیکیشن مجتمع آملی خوش آمدید!",
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
      Get.snackbar(
        "وضعیت",
        "لطفا تمام فیلد ها را پر کنید",
      );
      return -1;
    } else if (password != repassword) {
      Get.snackbar(
        "وضعیت",
        "گذرواژه شما با هم مطابقت ندارد...\nلطفا آن را تصحیح نمایید.",
      );
      return -1;
    } else if (password.length < 4) {
      Get.snackbar(
        "وضعیت",
        "گذرواژه نمیتواند کمتر از ۴ کاراکتر باشد",
      );
      return -1;
    } else if ((int.tryParse(vahed) != null ? int.parse(vahed) : 5) > 20) {
      Get.snackbar(
        "وضعیت",
        "لطفا واحد خود را تصحیح نمایید(هر بلوک ۲۰ واحد دارد)",
      );
      return -1;
    } else if ((int.tryParse(bluck) != null ? int.parse(bluck) : 5) > 3) {
      Get.snackbar(
        "وضعیت",
        "لطفا بلوک خود را تصحیح نمایید",
      );
      return -1;
    } else if (phone.length != 11 || !phone.contains("09")) {
      Get.snackbar(
        "وضعیت",
        "الگوی شماره تلفن شما درست نمیباشد",
      );
      return -1;
    }
  }

  static changePrice(username, password, price) async {
    Map payload = {"username": username, "password": password, "price": price};

    Uri url = Uri.parse("$host/adminpanel/change_price.php");
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
    var url = Uri.parse("$host/userapi/get_price.php");
    var request = await http.get(url);
    var response = request.body.replaceAll(RegExp(r"0$"), "");

    return response + " تومان";
  }

  static checkUser() async {
    var url = Uri.parse("$host/userapi/login.php");
    var payload = {
      "username": Hive.box("auth").get("username"),
      "password": Hive.box("auth").get("password")
    };
    var request = await http.post(url, body: payload);
    return request.body;
  }

  static getMyCharge() async {
    var year = await getYear();
    var url = Uri.parse(
      "$host/userapi/get_charge_status.php",
    );
    var payload = {
      "username": Hive.box("auth").get("username"),
      "year": year,
    };
    var request = await http.post(url, body: payload);
    return [request.body, year];
  }

  static getUserCharge(target) async {
    var year = await getYear();
    var name_family = await getUsersName(target);
    var url = Uri.parse("$host/userapi/get_charge_status.php");
    var payload = {"username": target, "year": year};
    var request = await http.post(url, body: payload);
    return [request.body, year, name_family];
  }

  static getYear() async {
    var url = Uri.parse("http://api.aladhan.com/gToH");
    var request = await http.get(url);
    var json = jsonDecode(request.body);
    return json["data"]["hijri"]["date"].split("-")[2];
  }

  static getUsersName(target) async {
    var url = Uri.parse("$host/adminpanel/get_user_name.php");
    var payload = {
      "target": target,
    };
    var request = await http.post(url, body: payload);
    return request.body;
  }

  static updateProfile(newusername, name, family, phone, bluck, vahed,
      startdate, enddate) async {
    Map payload = {
      "username": Hive.box("auth").get("username"),
      "password": Hive.box("auth").get("password"),
      "newusername": newusername,
      "name": name,
      "family": family,
      "phone": phone,
      "bluck": bluck,
      "vahed": vahed,
      "startdate": startdate == "**/**/**" ? "" : startdate,
      "enddate": enddate == "**/**/**" ? "" : enddate,
    };
    var url = Uri.parse("$host/userapi/update_profile.php");
    var req = await http.post(url, body: payload);
    return req.body;
  }

  static updateMonth(month) async {
    var url = Uri.parse("$host/adminpanel/update_month.php");
    var payload = {
      "username": Hive.box("auth").get("username"),
      "password": Hive.box("auth").get("password"),
      "month": month,
    };
    var req = await http.post(url, body: payload);
    return req.body;
  }

  static adminTypeChanger(type) {
    //if we wanna set something for another complexes, we should edit this function.
    if (type == "bluck1") {
      return "مدیر بلوک۱";
    } else if (type == "bluck2") {
      return "مدیر بلوک۲";
    } else if (type == "bluck3") {
      return "مدیر بلوک۳";
    } else if (type == "no") {
      return "کاربر عادی";
    }
  }

  static getCurrentMonthCharge() async {
    var url = Uri.parse("$host/userapi/get_month.php");
    var req = await http.get(url);
    return jsonDecode(req.body)["result"];
  }

  static getDatabaseYears() async {
    var url = Uri.parse("$host/userapi/get_years.php");
    var req = await http.get(url);
    return jsonDecode(req.body);
  }

  static getAbprice(target) async {
    var url = Uri.parse("$host/userapi/get_abprice.php");
    var payload = {
      "username": target,
    };
    var req = await http.post(url, body: payload);
    return jsonDecode(req.body);
  }
}

class PaymentController extends GetxController {
  //initial vars.
  Rx<TextEditingController> customizeTxt = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  List months = [];
  RxString year = "".obs;
  var moharam = false.obs;
  var safar = false.obs;
  var rabiol1 = false.obs;
  var rabiol2 = false.obs;
  var jamadi1 = false.obs;
  var jamadi2 = false.obs;
  var rajab = false.obs;
  var shaban = false.obs;
  var ramezan = false.obs;
  var shaval = false.obs;
  var zighade = false.obs;
  var zilhaje = false.obs;
  RxList ymd = [].obs; //means year month description.
  ///////////// functions.
  getUrl() async {
    String username = Hive.box("auth").get("username");
    String month = await Functions.getCurrentMonthCharge();
    String year = await Functions.getYear();
    String url =
        "http://localhost/mojtama/src/payment/simpleRequest.php?username=$username&month=$month&year=$year";
    Uri uri = Uri.parse(url);
    http.Response req = await http.post(uri);
    Map response = json.decode(req.body);
    return response["url"];
  }

  getCustomUrl(data) async {
    //this function gets a valid url from zibal which is customized by the user's price.
    String username = Hive.box("auth").get("username");
    Uri url =
        Uri.parse("http://localhost/mojtama/src/payment/customRequest.php");
    var payload = {
      "username": username,
      "json": data,
    };
    //print(payload);
    var req = await http.post(url, body: payload);
    var js;
    try {
      js = json.decode(req.body);
    } catch (e) {
      Get.snackbar(
        "وضعیت",
        "خروجی نامعتبر است.",
      );
    }

    print(req.body);
    if (js["message"] == "amount<100 IRR") {
      Get.snackbar(
        "وضعیت",
        "قیمت را کمتر از ۱۰۰۰ ریال وارد کرده‌اید.",
      );
    } else if (js["message"] == "success") {
      return js["url"];
    }
  }
}
//TODO: i'm here. i'm gonna code indicating charge of members of complex.
