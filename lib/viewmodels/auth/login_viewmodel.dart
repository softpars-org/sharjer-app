import 'package:flutter/material.dart';
import 'package:mojtama/exceptions/app_exceptions.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/screens/home_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SnackbarService snackbarService;
  final AppService appService;
  bool isLoginLoading = false;
  LoginViewModel({
    required this.snackbarService,
    required this.appService,
  });
  handleLoginRequest() async {
    UserProvider api = UserProvider(
      snackbarService: snackbarService,
    );
    final isFormValidated = loginFormKey.currentState!.validate();
    if (isFormValidated) {
      setLoading(true);
      try {
        bool isLoggined =
            await api.login(usernameController.text, passwordController.text);
        if (isLoggined) {
          snackbarService.showSnackbar(message: "ورود با موفقیت انجام شد");
          appService.navigateReplace(HomeScreen());
        } else {
          snackbarService.showSnackbar(
            message: "نام کاربری و یا گذرواژه شما اشتباه است",
          );
        }
      } on CannotConnectToTheServerException catch (e) {
        snackbarService.showSnackbar(message: "نتوانستیم به سرور متصل شویم");
      }
      setLoading(false);
    }
  }

  String? validateUsername(String? username) {
    return username?.isEmpty ?? true
        ? "لطفا نام کاربری خود را وارد کنید"
        : null;
  }

  String? validatePassword(String? password) {
    return password?.isEmpty ?? true ? "لطفا گذرواژه خود را وارد کنید" : null;
  }

  setLoading(bool newVal) {
    isLoginLoading = newVal;
    notifyListeners();
  }
}
