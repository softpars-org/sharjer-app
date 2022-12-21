import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/auth_screens/signup_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  ProfileHelper profileHelper = ProfileHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحه ورود"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomTextField(
                label: "نام کاربری",
                suffixIcon: Icon(Icons.person_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomTextField(
                label: "گذرواژه",
                suffixIcon: Icon(Icons.password_outlined),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                text: "ورود",
                icon: Icons.login,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextButton(
                child: Text("حساب کاربری ندارید؟ ثبت نام"),
                onPressed: () {
                  _key.currentState!.validate();
                  AppService appService = AppService(context);
                  appService.navigate(SignupPage());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "محصول مجتمع آملی ⓒ",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
