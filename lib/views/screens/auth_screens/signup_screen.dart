import 'package:flutter/material.dart';
import 'package:mojtama/views/screens/profile_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/plakinput_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحه ثبت نام"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "نام"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "نام خانوادگی"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "بلوک"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "واحد"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "شماره همراه"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "شماره همراه ۲"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "تعداد نفرات",
                    suffixIcon: Icon(Icons.car_repair),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "نام خانوادگی"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "تاریخ ورود"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "تاریخ خروج"),
                ),
              ),
            ],
          ),
          PlakInputWidget(),
          OwnerStatusCheckbox(),
          Padding(
            padding: EdgeInsets.all(8),
            child: CustomButton(
              onPressed: () {},
              icon: Icons.edit,
              text: "ثبت‌ نام",
            ),
          ),
        ],
      ),
    );
  }
}
