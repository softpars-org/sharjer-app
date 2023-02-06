import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/rule_model.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/encryption_service.dart';

class UserProvider {
  String? host;
  final _box = Hive.box("auth");
  UserProvider() {
    host = "http://localhost/mojtama-server-mvc";
  }

  login(String username, String password) async {
    var url = Uri.parse("$host/authentication/login");
    Encryption encryption = Encryption();
    password = await encryption.encrypt(password);
    Map<String, dynamic> payload = {
      "username": username,
      "password": password,
    };
    http.Response request;
    try {
      request = await http.post(url, body: payload);
      if (request.statusCode == 200) {
        _box.put("is_loggined", true);
        _box.put("username", username);
        _box.put(
          "password",
          password,
        );
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<int> signup(User userInfo) async {
    var url = Uri.parse("$host/authentication/signup");
    Encryption encryption = Encryption();
    userInfo.password = await encryption.encrypt(userInfo.password);
    Map<String, dynamic> payload = {
      "username": userInfo.username,
      "password": userInfo.password,
      "name": userInfo.name,
      "family": userInfo.family,
      "phone": userInfo.phone,
      "phone2": userInfo.phone2,
      "bluck": userInfo.bluck.toString(),
      "vahed": userInfo.vahed.toString(),
      "family_members": userInfo.familyMembers.toString(),
      "car_plate": userInfo.carPlate,
      "start_date": userInfo.startDate,
      "end_date": userInfo.endDate,
      "is_owner": userInfo.isOwner.toString(),
    };
    http.Response request;
    request = await http.post(url, body: payload);
    print(request.body);
    Map<String, dynamic> response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      _box.put("is_loggined", true);
      _box.put("username", userInfo.username);
      _box.put(
        "password",
        userInfo.password,
      );
      return 1; //everything works fine!
    } else if (response["message"] == "user is in the database") {
      return -1; //means user exists
    } else {
      return 0; //means there is a problem.
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
    Future.delayed(
        const Duration(seconds: 2), () => print("Checking version..."));
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
    Map<String, dynamic> payload = {
      "username": _box.get("username"),
      "password": _box.get("password"),
    };
    request = await http.post(url, body: payload);
    List response = jsonDecode(request.body);
    List<ChargeRowStatus> chargeRows = [];
    if (request.statusCode == 200) {
      for (var jsonedChargeRow in response) {
        ChargeRowStatus chargeRow = ChargeRowStatus.fromJson(jsonedChargeRow);
        chargeRows.add(chargeRow);
      }
      return chargeRows;
    }
    return false;
  }

  Future<List<dynamic>> getYears() async {
    var url = Uri.parse("$host/user/get_years");
    http.Response request;
    request = await http.get(url);
    List<dynamic> years = jsonDecode(request.body);
    return years;
  }

  Future<dynamic> getMyProfile() async {
    var url = Uri.parse("$host/user/get_myself");
    Map<String, dynamic> body = {
      "username": _box.get("username"),
      "password": _box.get("password")
    };
    http.Response request = await http.post(url, body: body);
    Map<String, dynamic> response = jsonDecode(request.body);
    if (request.statusCode == 200) {
      return User.fromJson(response["data"]);
    }
    return false;
  }

  Future<String> getMyPermission() async {
    var getProfileResponse = await getMyProfile();
    if (getProfileResponse == false) {
      return "no"; //means no permission
    } else {
      String myPermission = getProfileResponse.userType;
      return myPermission;
    }
  }

  Future<dynamic> updateInformation(Map<String, dynamic> information) async {
    var url = Uri.parse("$host/user/update_myself");
    http.Response request;
    request = await http.post(url, body: information);
    if (request.statusCode == 200) {
      print(request.body);
      return true;
    }
    print(request.body);
    return false;
  }
}
