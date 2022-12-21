import 'package:http/http.dart' as http;

class UserProvider {
  String? host;
  UserProvider() {
    host = "http://amolicomplex.freehost.io";
  }

  checkApplicationVersion() async {
    Future.delayed(Duration(seconds: 2), () => print("Checking version..."));
    return {
      "status": "not updated",
      "version": "1.1.1",
      "link": "https://www.google.com",
    };
  }
}
