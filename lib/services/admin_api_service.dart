import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

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
}
