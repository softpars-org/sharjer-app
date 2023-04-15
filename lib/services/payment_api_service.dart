import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/models/history_model.dart';

class PaymentProvider {
  String? host;
  final _box = Hive.box("auth");
  PaymentProvider() {
    host = "https://amolicomplex.ir/mojtama-server-mvc/";
  }

  getCurrentMonth() async {
    var url = Uri.parse("$host/user/get_month");
    http.Response request;
    request = await http.get(url);
    Map<String, dynamic> response = jsonDecode(request.body);
    return response["month"];
  }

  getChargeUrl() async {
    var url = Uri.parse("$host/payment/simple_charge");
    http.Response request;
    Map<String, dynamic> body = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    request = await http.post(url, body: body);
    Map<String, dynamic> response = jsonDecode(request.body);
    if (response.containsKey("url")) {
      return response["url"];
    } else if (response["status"] == "charge_paid") {
      return "charge_paid";
    }
    return false;
  }

  getCustomChargeUrl(String jsonChargeInfo) async {
    var url = Uri.parse("$host/payment/custom_charge");
    http.Response request;
    Map<String, dynamic> body = {
      "username": _box.get("username"),
      "password": _box.get("password"),
      "json": jsonChargeInfo,
    };
    request = await http.post(url, body: body);
    print(request.body);
    Map<String, dynamic> response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      return response["url"];
    } else {
      return response["message"];
    }
  }

  getPaymentHistory() async {
    var url = Uri.parse("$host/payment/get_payment_history");
    http.Response request;
    request = await http.get(url);
    List response = jsonDecode(request.body);
    List<History> paymentHistory = [];
    for (var jsonHistory in response) {
      paymentHistory.add(History.fromJson(jsonHistory));
    }
    if (paymentHistory.isNotEmpty) {
      return paymentHistory;
    }
    return false;
  }
}
