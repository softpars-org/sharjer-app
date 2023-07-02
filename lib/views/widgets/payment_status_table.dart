import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';

class PaymentStatusTable extends StatelessWidget {
  final ChargeRowStatus chargeStatusOfTheUser;
  final String year;
  final String name;
  const PaymentStatusTable({
    super.key,
    required this.year,
    required this.chargeStatusOfTheUser,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Center(
            child: Text(
              chargeStatusOfTheUser.year,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Center(
            child: Text(name),
          ),
          const Divider(),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
