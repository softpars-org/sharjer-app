import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final Map<String, dynamic> decodedJson;
  const CustomTable({super.key, required this.decodedJson});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      children: [
        ...List.generate(
          decodedJson.length,
          (index) {
            String title = decodedJson.keys.toList()[index].toString();
            String value = decodedJson.values.toList()[index].toString();
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
    );
  }
}
