import 'package:flutter/material.dart';
import 'package:mojtama/models/adminpanel_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:provider/provider.dart';

class FinancialAdminStatusScreen extends StatelessWidget {
  const FinancialAdminStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppService service = AppService(context);
    final providerModel = Provider.of<AdminPanelModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("وضعیت مالی مجتمع"),
      ),
      body: Consumer<AdminPanelModel>(
        builder: (context, model, child) {
          return ListView(
            children: [
              ...model.textFieldList,
              if (child != null) child,
            ],
          );
        },
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  providerModel.removeTextField();
                },
                child: const Text("حذف آخرین فیلد"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  providerModel.addTextField();
                },
                child: const Text("اضافه کردن فیلد جدید"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var test = providerModel.generateJsonFromFields();
          print(test);
        },
        tooltip: "ثبت مبالغ",
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}
