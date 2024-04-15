import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';

class NetworkViewModel extends ChangeNotifier {
  final SnackbarService snackbarService;
  bool connected = true;
  NetworkViewModel({required this.snackbarService});
  onNetworkChange() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        connected = false;
        snackbarService.showSnackbar(message: "اینترنت شما فعال نیست");
        notifyListeners();
        return;
      }
      connected = true;
      notifyListeners();
    });
  }
}
