import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';
import 'package:provider/provider.dart';

class RemoveChargeFromUserScreen extends StatelessWidget {
  String username;
  RemoveChargeFromUserScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حذف شارژ کاربر"),
      ),
      body: ListView(
        children: [
          const Divider(),
          const YearDropDownWidget(),
          const Divider(),
          ...List.generate(
            12,
            (index) => RadioButton(monthIndex: index),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AdminProvider api = AdminProvider();
          AppService appService = AppService(context);
          var yearModel = Provider.of<YearModel>(context, listen: false);
          var monthModel = Provider.of<RadioMonthModel>(context, listen: false);
          String year = yearModel.year;
          int monthIndex = monthModel.currentValue;
          String month = monthModel.months[monthIndex];
          bool isRemoved = await api.removeChargeFromUser(
            username,
            year,
            month,
          );
          if (isRemoved) {
            appService.snackBar("ماه $month با موفقیت حذف شد.");
          } else {
            appService.snackBar("ثبت ماه $month با مشکلی مواجه گردید.");
          }
        },
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
