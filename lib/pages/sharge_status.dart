import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ShargeStatusPage extends StatefulWidget {
  @override
  _ShargeStatusPageState createState() => _ShargeStatusPageState();
}

class _ShargeStatusPageState extends State<ShargeStatusPage> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("theme");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: TextField(
              autocorrect: false,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: "نام فرد را وارد کنید...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Text(
          //   "وضعیت شارژ ساکنین",
          //   style: TextStyle(fontWeight: FontWeight.w300),
          // ),
          leading: IconButton(
            color: !box.get("is_dark") ? Colors.blue : Colors.amber,
            icon: Icon(Icons.arrow_back),
            tooltip: "برگشت",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: TABLE(),
          ),
        ),
      ),
    );
  }
}

class TABLE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("theme");
    Color color = box.get("is_dark") ? Colors.yellow[900] : Colors.blue[900];
    return Container(
      child: Table(
        border: TableBorder.all(
          color: Hive.box("theme").get("is_dark") ? Colors.white : Colors.black,
        ),
        children: [
          TableRow(
            children: [
              Text(
                "نام و نام خانوادگی",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "سال شارژ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "ماه شارژ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "تاریخ پرداخت",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "مبلغ پرداخته شده",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Text("علی نیک نیا"),
              Text(""),
              Text(""),
              Text("4"),
              Text("5"),
            ],
          ),
        ],
      ),
    );
  }
}
