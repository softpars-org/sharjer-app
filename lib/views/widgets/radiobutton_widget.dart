import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:provider/provider.dart';

class RadioButton extends StatelessWidget {
  int monthIndex;

  RadioButton({super.key, required this.monthIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioMonthModel>(
      builder: (context, model, child) {
        return RadioListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          value: monthIndex,
          title: Text(model.months[monthIndex]),
          groupValue: model.currentValue,
          onChanged: model.changeItem,
        );
      },
    );
  }
}
