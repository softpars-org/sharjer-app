import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddChargeToUserScreen extends StatelessWidget {
  AddChargeToUserScreen({super.key});
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProfileHelper helper = ProfileHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافه کردن شارژ به کاربر"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "بلوک",
                      validator: helper.isNonNullNumber,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "واحد",
                      validator: helper.isNonNullNumber,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            YearDropDownWidget(),
            ...List.generate(
              12,
              (index) => RadioButton(monthIndex: index),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isOk = _formKey.currentState!.validate();
        },
        child: Icon(Icons.check_rounded),
      ),
    );
  }
}
