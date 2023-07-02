import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/month_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:provider/provider.dart';

class ChangeMonthScreen extends StatelessWidget {
  const ChangeMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغییر ماه شارژ"),
      ),
      body: ListView(
        children: List.generate(
          12,
          (index) => RadioButton(
            monthIndex: index,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AdminProvider api = AdminProvider();
          RadioMonthModel model =
              Provider.of<RadioMonthModel>(context, listen: false);
          int currentIndex = model.currentValue;
          bool isUpdated = await api.updateMonth(model.months[currentIndex]);
          if (isUpdated) {
            AppService(context).snackBar("ماه شارژ با موفقیت تغییر کرد.");
          } else {}
        },
        tooltip: "تعویض ماه",
        child: const Icon(Icons.change_circle),
      ),
    );
  }
}
