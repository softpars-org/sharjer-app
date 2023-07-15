import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/config/strings.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/user_model.dart';

class AdminProvider {
  String? host;
  final _box = Hive.box("auth");
  AdminProvider() {
    host = Strings.baseURL;
  }

  updateMonth(month) async {
    var url = Uri.parse("$host/adminpanel/update_month/$month");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    return (request.statusCode == 200);
  }

  updatePrice(price) async {
    var url = Uri.parse("$host/adminpanel/update_price/$price");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    return (request.statusCode == 200);
  }

  addOrUpdateMojtamaRule(String rule) async {
    var url = Uri.parse("$host/adminpanel/add_mojtama_rules/");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "rule": rule,
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    request = await http.post(url, body: payload);
    return (request.statusCode == 200);
  }

  addOrUpdateMojtamaFinancialStatus(String json) async {
    var url = Uri.parse("$host/adminpanel/add_mojtama_financial_status/");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "financial_json": json,
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return (request.statusCode == 200);
  }

  getUsers() async {
    var url = Uri.parse("$host/adminpanel/users");
    http.Response request;
    try {
      request = await http.get(url);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    List<User> users = [];
    if (request.statusCode == 200) {
      List listUsers = jsonDecode(request.body);
      for (var arrUser in listUsers) {
        User user = User.fromJson(arrUser);
        users.add(user);
      }
      return users;
    } else {
      return false;
    }
  }

  addChargeToUser(String targetUsername, String jsonedChargeData) async {
    var url = Uri.parse("$host/adminpanel/add_multiple_charge_to_user/");
    http.Response request;
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "target_username": targetUsername,
      "json": jsonedChargeData,
    };
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    Map<String, dynamic> response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      if (response["message"] == "charges were added") {
        return response["months"];
      }
    } else {
      return false;
    }
  }

  removeChargeFromUser(
    String targetUsername,
    String year,
    String month,
  ) async {
    var url = Uri.parse("$host/adminpanel/remove_charge_from_user");
    http.Response request;
    Map<String, dynamic> body = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "target_username": targetUsername,
      "year": year,
      "month": month,
    };
    try {
      request = await http.post(url, body: body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return (request.statusCode == 200);
  }

  changeMonthsPriceOfYear(String year, Map<String, int> monthsPrices) async {
    var url = Uri.parse("$host/adminpanel/change_months_price/");
    String jsonMonths = jsonEncode(monthsPrices);
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "year": year,
      "months": jsonMonths
    };
    try {
      http.Response request = await http.post(url, body: payload);
      if (request.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  changeUserPrivilege(String username, String privilege) async {
    var url =
        Uri.parse("$host/adminpanel/change_privilege/$username/$privilege");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    switch (request.statusCode) {
      case 200:
        return true;
      case 401:
        return -1;
      default:
        return false;
    }
  }

  getMonthsPricesInfo() async {
    var url = Uri.parse("$host/adminpanel/months_price");
    http.Response request;
    try {
      request = await http.get(url);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    Map<String, dynamic> response = jsonDecode(request.body);
    return response;
  }

  getChargeStatusOfAMember(String username) async {
    var url = Uri.parse("$host/adminpanel/get_charge_status_of/$username");
    http.Response request;
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    List<ChargeRowStatus> charges = [];
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return charges;
    }

    if (request.statusCode == 200) {
      List<dynamic> response = jsonDecode(request.body);
      for (var element in response) {
        ChargeRowStatus chargeRow = ChargeRowStatus.fromJson(element);
        charges.add(chargeRow);
      }
      return charges;
    } else if (request.statusCode == 401) {
      return charges;
    }
  }

  sendNotif(String title, String body) async {
    var url = Uri.parse("$host/adminpanel/send_notif/$title");
    Map<String, String> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "body": body,
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return (request.statusCode == 200);
  }
}
