import 'package:flutter/material.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';

class RemoveChargeFromUserScreen extends StatelessWidget {
  const RemoveChargeFromUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حذف شارژ کاربر"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    label: "بلوک",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    label: "واحد",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          YearDropDownWidget(),
          Divider(),
          ...List.generate(
            12,
            (index) => RadioButton(monthIndex: index),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.check_rounded),
      ),
    );
  }
}
