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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
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
          child: Consumer<YearModel>(builder: (context, model, child) {
            print(model.years);
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
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              alignment: Alignment.center,
              hint: const Text("سال شارژ"),
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
