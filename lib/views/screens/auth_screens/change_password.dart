import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/encryption_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/viewmodels/change_password_model.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String plainPassword = "";

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () async => getPassword());
  }

  @override
  Future<void> getPassword() async {
    var box = Hive.box("auth");
    ChangePasswordModel model =
        Provider.of<ChangePasswordModel>(context, listen: false);
    String encryptedPassword = box.get("password");
    String plainPassword = await Encryption().decrypt(encryptedPassword);
    model.changePlainPassword(plainPassword);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغییر رمز عبور"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ChangePasswordModel>(
                  builder: (context, model, child) {
                return Text("گذرواژه فعلی شما: ${model.plainPassword}");
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: passwordController,
                label: "گذرواژه جدید خود را وارد کنید",
                obscureText: true,
                suffixIcon: Icon(Icons.password_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: reEnterPasswordController,
                label: "گذرواژه جدید خود را دوباره وارد کنید",
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "مقدار باید پر باشد";
                  } else if (value != passwordController.text) {
                    return "مقدار این ورودی باید برابر با گذرواژه وارد شده شما باشد.";
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.password_outlined),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isValidated = formKey.currentState!.validate();
          if (isValidated) {
            UserProvider userProvider = UserProvider();
            var box = Hive.box("auth");
            AppService appService = AppService(context);
            Encryption encryption = Encryption();
            bool isPasswordUpdated =
                await userProvider.changePassword(passwordController.text);
            if (isPasswordUpdated) {
              appService.snackBar("گذرواژه با موفقیت تغییر کرد.");
              String encryptedPassword =
                  await encryption.encrypt(passwordController.text);
              box.put("password", encryptedPassword);
            }
          }
        },
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
