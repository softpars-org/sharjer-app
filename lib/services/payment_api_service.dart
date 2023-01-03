import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class PaymentProvider {
  String? host;
  final _box = Hive.box("auth");
  PaymentProvider() {
    host = "http://localhost/mojtama-server-mvc/";
  }

  getCurrentMonth() async {
    var url = Uri.parse("$host/user/get_month");
    http.Response request;
    request = await http.get(url);
    Map<String, dynamic> response = jsonDecode(request.body);
    return response["month"];
  }
}
