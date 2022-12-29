import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/rule_model.dart';
import 'package:mojtama/models/user_model.dart';

class UserProvider {
  String? host;
  final _box = Hive.box("auth");
  UserProvider() {
    host = "http://localhost/mojtama-server-mvc/";
  }

  login(String username, String password) async {
    var url = Uri.parse("$host/authentication/login");
    List<int> passwordBytes = utf8.encode(password);
    String md5hashedPassword = md5.convert(passwordBytes).toString();

    Map<String, dynamic> payload = {
      "username": username,
      "password": md5hashedPassword,
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
      if (request.statusCode == 200) {
        _box.put("is_loggined", true);
        _box.put("username", username);
        _box.put(
          "password",
          md5hashedPassword,
        );
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  signup(User userInfo) async {
    var url = Uri.parse("$host/authentication/signup");
    Map<String, dynamic> payload = {
      "username": userInfo.username,
      "password": userInfo.password,
      "name": userInfo.name,
      "family": userInfo.family,
      "phone": userInfo.phone,
      "phone2": userInfo.phone2,
      "bluck": userInfo.bluck,
      "vahed": userInfo.vahed,
      "family_members": userInfo.familyMembers,
      "car_plate": userInfo.carPlate,
      "start_date": userInfo.startDate,
      "end_date": userInfo.endDate,
      "is_owner": userInfo.isOwner,
    };
    http.Response request;
    request = await http.post(url, body: payload);
    if (request.statusCode == 200) {
      return true; //TODO: needs to be completed
    } else {
      return false;
    }
  }

  getFinancialStatus() async {
    var url = Uri.parse("$host/user/get_financial_status");
    http.Response request;
    request = await http.get(url);
    if (request.statusCode == 200) {
      return request.body;
    } else {
      return false;
    }
  }

  getMojtamaRules() async {
    var url = Uri.parse("$host/user/get_mojtama_rules");
    http.Response request;
    request = await http.get(url);
    if (request.statusCode == 200) {
      Map<String, dynamic> decodedBody = jsonDecode(request.body);
      return Rule.fromMap(decodedBody["data"][0]);
    } else {
      return false;
    }
  }

  checkApplicationVersion() async {
    Future.delayed(Duration(seconds: 2), () => print("Checking version..."));
    return {
      "status": "not updated",
      "version": "1.1.1",
      "link": "https://www.google.com",
    };
  }

  Future<String?> getPaymentStatusMessageOfTheUsers() async {
    var url = Uri.parse("$host/user/people_who_charged_this_month");
    http.Response request;
    request = await http.get(url);
    Map<String, dynamic> response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      return response["data"];
    }
    return null;
  }

  getUserChargeStatus() async {
    var url = Uri.parse("$host/user/user_pay_stat");
    http.Response request;
    request = await http.get(url);
    String jsjsjs =
        '[{"1444":{"\u0648\u0627\u062d\u062f":13,"\u0645\u062d\u0631\u0645":4000,"\u0635\u0641\u0631":0,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u0627\u0648\u0644":0,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u062b\u0627\u0646\u06cc":320000,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u0627\u0648\u0644":0,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u062b\u0627\u0646\u06cc":0,"\u0631\u062c\u0628":0,"\u0634\u0639\u0628\u0627\u0646":0,"\u0631\u0645\u0636\u0627\u0646":0,"\u0634\u0648\u0627\u0644":0,"\u0630\u06cc\u0642\u0639\u062f\u0647":0,"\u0630\u06cc\u062d\u062c\u0647":0,"\u062c\u0645\u0639":324000}},{"1443":{"\u0648\u0627\u062d\u062f":13,"\u0645\u062d\u0631\u0645":1000000,"\u0635\u0641\u0631":1000000,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u0627\u0648\u0644":1000000,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u062b\u0627\u0646\u06cc":1000000,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u0627\u0648\u0644":0,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u062b\u0627\u0646\u06cc":1000000,"\u0631\u062c\u0628":1000000,"\u0634\u0639\u0628\u0627\u0646":1000000,"\u0631\u0645\u0636\u0627\u0646":1000000,"\u0634\u0648\u0627\u0644":1000000,"\u0630\u06cc\u0642\u0639\u062f\u0647":1000000,"\u0630\u06cc\u062d\u062c\u0647":1000000,"\u062c\u0645\u0639":11000000}},{"1441":{"\u0648\u0627\u062d\u062f":13,"\u0645\u062d\u0631\u0645":0,"\u0635\u0641\u0631":0,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u0627\u0648\u0644":0,"\u0631\u0628\u06cc\u0639 \u0627\u0644\u062b\u0627\u0646\u06cc":0,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u0627\u0648\u0644":0,"\u062c\u0645\u0627\u062f\u06cc \u0627\u0644\u062b\u0627\u0646\u06cc":0,"\u0631\u062c\u0628":0,"\u0634\u0639\u0628\u0627\u0646":0,"\u0631\u0645\u0636\u0627\u0646":0,"\u0634\u0648\u0627\u0644":0,"\u0630\u06cc\u0642\u0639\u062f\u0647":0,"\u0630\u06cc\u062d\u062c\u0647":0,"\u062c\u0645\u0639":0}}]';
    List de = jsonDecode(jsjsjs);
    print(de);
    List response = jsonDecode(request.body);
    List<ChargeRowStatus> chargeRows = [];
    if (request.statusCode == 200) {
      response.forEach((jsonedChargeRow) {
        ChargeRowStatus chargeRow = ChargeRowStatus.fromJson(jsonedChargeRow);
        chargeRows.add(chargeRow);
      });
      return chargeRows;
    }
    return false;
  }
}
