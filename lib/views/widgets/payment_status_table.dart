import 'package:flutter/material.dart';

class PaymentStatusTable extends StatelessWidget {
  Map<String, Map>? chargeStatusOfTheUser;
  String year;
  PaymentStatusTable({
    super.key,
    this.chargeStatusOfTheUser,
    this.year = "1444",
  });

  @override
  Widget build(BuildContext context) {
    chargeStatusOfTheUser = {
      "1444": {
        "واحد": "13",
        "ربیع الاول": "10000",
      },
      "1443": {
        "واحدم": "دو هستش",
      }
    };
    int chargeStatusOfTheUserLength = chargeStatusOfTheUser!.length;
    Map chargeStatusOfTheUserInCurrentYear = chargeStatusOfTheUser![year]!;
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Center(
            child: Text(
              year,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Center(
            child: Text("محمدمهدی بنیادی"),
          ),
          Divider(),
          Table(
            border: TableBorder.all(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            children: [
              ...List.generate(
                chargeStatusOfTheUserLength,
                (index) {
                  String title = chargeStatusOfTheUserInCurrentYear.keys
                      .toList()[index]
                      .toString();
                  String value = chargeStatusOfTheUserInCurrentYear.values
                      .toList()[index]
                      .toString();
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
