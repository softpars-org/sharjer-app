import 'package:flutter/material.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class MojtamaRulesScreen extends StatelessWidget {
  MojtamaRulesScreen({super.key});
  TextEditingController ruleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model =
        Provider.of<MojtamaStatusExpansionModel>(context, listen: false);
    ruleController.text = model.mojtamaRule.rule;
    return Scaffold(
      appBar: AppBar(
        title: const Text("قوانین مجتمع"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "محل قرارگیری قوانین",
              controller: ruleController,
              maxLines: 20,
              suffixIcon: const Icon(Icons.rule_sharp),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AdminProvider api = AdminProvider();
          bool isUpdated =
              await api.addOrUpdateMojtamaRule(ruleController.text);
          if (isUpdated) {
            AppService(context).snackBar("با موفقیت قانون ثبت گردید");
          } else {
            AppService(context).snackBar("مشکلی در ثبت قانون پیش آمد");
          }
        },
        tooltip: "تایید",
        child: const Icon(
          Icons.check_rounded,
        ),
      ),
    );
  }
}
