import 'package:flutter/material.dart';

class YearTable extends StatelessWidget {
  var json;
  int? year;
  String? name;
  YearTable({this.json, this.year, this.name});
  @override
  //get keys of json which returns the status of charge!
  List getKeys(Map map) {
    List keys = [];
    map.keys.forEach((element) {
      keys.add(element);
    });
    return keys;
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
          "سال $year",
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
            children: List.generate(getKeys(json).length, (index) {
              var value = json[getKeys(json)[index]].toString();

              return TableRow(children: [
                Padding(
                  child: Text(
                    getKeys(json)[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(8),
                ),
                Padding(
                  child: Text(
                    value.replaceAll(RegExp(r".$"), ""),
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
