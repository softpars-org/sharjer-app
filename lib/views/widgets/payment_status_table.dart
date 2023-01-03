import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';

class PaymentStatusTable extends StatelessWidget {
  ChargeRowStatus chargeStatusOfTheUser;
  String year;
  PaymentStatusTable({
    super.key,
    required this.year,
    required this.chargeStatusOfTheUser,
  });

  @override
  Widget build(BuildContext context) {
    // chargeStatusOfTheUser = {
    //   "1444": {
    //     "واحد": "13",
    //     "ربیع الاول": "10000",
    //   },
    //   "1443": {
    //     "واحدم": "دو هستش",
    //   }
    // };

    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Center(
            child: Text(
              chargeStatusOfTheUser.year,
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
                chargeStatusOfTheUser.months.length,
                (index) {
                  String title = chargeStatusOfTheUser.months[index].toString();
                  String value = chargeStatusOfTheUser.prices[index].toString();
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
