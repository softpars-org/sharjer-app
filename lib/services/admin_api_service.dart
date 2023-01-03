import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/models/user_model.dart';

class AdminProvider {
  String? host;
  final _box = Hive.box("auth");
  AdminProvider() {
    host = "http://localhost/mojtama-server-mvc/";
  }

  updateMonth(month) async {
    var url = Uri.parse("$host/adminpanel/update_month/$month");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    http.Response request;
    request = await http.post(url, body: payload);
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  updatePrice(price) async {
    var url = Uri.parse("$host/adminpanel/update_price/$price");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
    };
    http.Response request;
    request = await http.post(url, body: payload);
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  addOrUpdateMojtamaRule(String rule) async {
    var url = Uri.parse("$host/adminpanel/add_mojtama_rules/");
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "rule": rule,
    };
    http.Response request;
    request = await http.post(url, body: payload);
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  getUsers() async {
    var url = Uri.parse("$host/adminpanel/users");
    http.Response request;
    request = await http.get(url);
    List<User> users = [];
    if (request.statusCode == 200) {
      List listUsers = jsonDecode(request.body);
      listUsers.forEach((arrUser) {
        User user = User.fromJson(arrUser);
        users.add(user);
      });
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
    request = await http.post(url, body: payload);
    Map<String, dynamic> response = jsonDecode(request.body);
    print(response);
    if (request.statusCode == 200) {
      if (response["message"] == "charges were added") {
        return response["months"];
      }
    } else {
      return false;
    }
  }
}
