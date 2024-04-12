import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/viewmodels/auth/login_viewmodel.dart';
import 'package:mojtama/viewmodels/network_viewmodel.dart';
import 'package:mojtama/views/screens/auth_screens/signup_screen.dart';
import 'package:mojtama/views/widgets/button_circular_progress_indicator_widget.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final ProfileHelper profileHelper = ProfileHelper();

  @override
  void initState() {
    super.initState();
    context.read<NetworkViewModel>().onNetworkChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("صفحه ورود")),
      body: ChangeNotifierProvider(
          create: (_) => LoginViewModel(
                snackbarService: SnackbarService(context),
                appService: AppService(context),
              ),
          builder: (context, child) {
            return Form(
              key: context.read<LoginViewModel>().loginFormKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextField(
                      label: "نام کاربری",
                      validator:
                          context.read<LoginViewModel>().validateUsername,
                      controller:
                          context.read<LoginViewModel>().usernameController,
                      suffixIcon: const Icon(Icons.person_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextField(
                      label: "گذرواژه",
                      validator:
                          context.read<LoginViewModel>().validatePassword,
                      controller:
                          context.read<LoginViewModel>().passwordController,
                      suffixIcon: const Icon(Icons.password_outlined),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Consumer<LoginViewModel>(
                        builder: (context, provider, child) {
                      return CustomButton(
                        text: "ورود",
                        widget: provider.isLoginLoading
                            ? const ButtonCircularProgressIndicator()
                            : null,
                        icon: provider.isLoginLoading ? Icons.abc : Icons.login,
                        onPressed: context.watch<NetworkViewModel>().connected
                            ? provider.handleLoginRequest
                            : null,
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      child: const Text("حساب کاربری ندارید؟ ثبت نام"),
                      onPressed: () {
                        AppService appService = AppService(context);
                        appService.navigate(SignupPage());
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "محصول گروه برنامه‌نویسی شارژر ⓒ",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
