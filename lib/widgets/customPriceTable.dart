import 'package:flutter/material.dart';

class CustomPriceTable extends StatelessWidget {
  var json;
  int? year;
  String? name;
  CustomPriceTable({this.json, this.year, this.name});
  @override
  //get keys of json which returns the status of charge!
  List getKeys(Map map) {
    //gets keys of the map
    List keys = [];
    map.keys.forEach((element) {
      keys.add(element);
    });
    return keys;
  }

  List getValues(Map map) {
    //gets values of the map
    List values = [];
    map.values.forEach((element) {
      values.add(element);
    });
    return values;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            name!,
          ),
        ),
        Text(
          "پرداخت",
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            textDirection: TextDirection.rtl,
            children: List.generate(json.length, (index) {
              return TableRow(children: [
                Padding(
                  child: Text(
                    getKeys(json)[index].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(8),
                ),
                Padding(
                  child: Text(
                    getValues(json)[index].toString(),
                  ), //replace the last zero with null value
                  padding: EdgeInsets.all(8),
                ),
              ]);
            }),
          ),
        ),
        Divider(
          indent: 30,
          endIndent: 30,
          thickness: 0.5,
        ),
      ],
    );
  }
}
