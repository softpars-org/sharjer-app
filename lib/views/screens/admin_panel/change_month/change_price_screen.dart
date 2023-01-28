import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:flutter/material.dart';

class ChangePriceScreen extends StatelessWidget {
  ChangePriceScreen({super.key});

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  ProfileHelper helper = ProfileHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغییر مبلغ شارژ"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
              child: CustomTextField(
                label: "مبلغ جدید شارژ را وارد کنید",
                controller: priceController,
                suffixIcon: Icon(Icons.price_change),
                helper: "مبلغ را به تومان وارد کنید.",
                keyboardType: TextInputType.number,
                validator: helper.isNotNull,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isOk = _key.currentState!.validate();
          if (isOk) {
            AdminProvider api = AdminProvider();
            bool isPriceUpdated = await api.updatePrice(priceController.text);
            if (isPriceUpdated) {
              AppService(context).snackBar("مبلغ این ماه با موفقیت تغییر کرد.");
            } else {
              AppService(context).snackBar("مشکلی در سمت سرور پیش آمد.");
            }
          }
        },
        tooltip: "تغییر مبلغ",
        child: Icon(Icons.change_circle_rounded),
      ),
    );
  }
}
