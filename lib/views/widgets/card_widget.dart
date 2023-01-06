import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojtama/models/history_model.dart';

class CustomCard extends StatelessWidget {
  History history;
  CustomCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    // DateTime date = DateTime.parse(history.date);
    // DateFormat dateFormatter = DateFormat("HH:mm,");
    // String paidAt = dateFormatter.format(date);
    return Container(
      padding: EdgeInsets.all(25),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(history.date),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  child: Text(history.fullName),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Text(
                      "پرداخت",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              endIndent: 5,
              indent: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                history.message,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
