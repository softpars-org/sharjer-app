import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  checkInternetConnection() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
