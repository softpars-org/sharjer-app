import 'package:flutter/material.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:provider/provider.dart';

class YearDropDownWidget extends StatefulWidget {
  const YearDropDownWidget({super.key});

  @override
  State<YearDropDownWidget> createState() => _YearDropDownWidgetState();
}

class _YearDropDownWidgetState extends State<YearDropDownWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<YearModel>(context, listen: false);
    await provider.getYears();
  }

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
              items: model.years
                  .map<DropdownMenuItem>(
                    (dynamic value) => DropdownMenuItem(
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
