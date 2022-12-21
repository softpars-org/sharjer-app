import 'package:flutter/material.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:provider/provider.dart';

class YearDropDownWidget extends StatelessWidget {
  const YearDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "سال شارژ",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Consumer<YearModel>(builder: (contex, model, child) {
            return DropdownButton(
              underline: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: ["One", "Two", "Three", "1444"]
                  .map<DropdownMenuItem>(
                    (String value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
              alignment: Alignment.center,
              hint: Text("سال شارژ"),
              borderRadius: BorderRadius.circular(10),
              onChanged: model.changeYear,
              value: model.year,
            );
          }),
        ),
      ],
    );
  }
}
