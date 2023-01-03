import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/months_checkbox_widget.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddChargeToUserScreen extends StatelessWidget {
  String username;
  AddChargeToUserScreen({super.key, required this.username});
  ProfileHelper helper = ProfileHelper();
  AdminProvider api = AdminProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافه کردن شارژ به کاربر"),
      ),
      body: ListView(
        children: [
          YearDropDownWidget(),
          Divider(),
          MonthsCheckBox(),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var yearModel = Provider.of<YearModel>(context, listen: false);
          var monthsModel = Provider.of<MonthsModel>(context, listen: false);
          List chargeMonthEntryInfo = [
            yearModel.year,
            monthsModel.months.values.map((e) => e).toList(),
          ];
          String jsonedChargeData = jsonEncode(chargeMonthEntryInfo);
          var addedMonths =
              await api.addChargeToUser(username, jsonedChargeData);
          AppService appService = AppService(context);
          if (addedMonths != false && addedMonths.isNotEmpty) {
            appService.snackBar("شارژ ماه $addedMonths به کاربر اضافه شد.");
          } else if (addedMonths.isEmpty) {
            appService.snackBar("شارژ هیچ ماهی به کاربر اضافه نشد.");
          } else {
            appService
                .snackBar("شارژ ماه‌های $addedMonths به کاربر اضافه نشد.");
          }
        },
        child: Icon(Icons.check_rounded),
      ),
    );
  }
}
