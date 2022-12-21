import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/views/widgets/radiobutton_widget.dart';
import 'package:provider/provider.dart';

class ChangeMonthScreen extends StatelessWidget {
  const ChangeMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغییر ماه شارژ"),
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
        onPressed: () {
          //TODO I'll implement it later.
        },
        tooltip: "تعویض ماه",
        child: Icon(Icons.change_circle),
      ),
    );
  }
}
