import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/customPriceTable.dart';

/*
Well, What's CustomStatusPage? it is a kind of statusPage(which indicates the User's charges). but it's the customed version.
*/
class CustomStatusPage extends StatelessWidget {
  String username;
  CustomStatusPage({this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لیست واریزی‌های جداگانه",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: Functions.getAbprice(username),
        builder: (cnx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView(
                  children: List.generate(
                snapshot.data.length,
                (index) => CustomPriceTable(
                  json: snapshot.data[index],
                  year: 1443,
                  name: "Sth special",
                ),
              )); //IT HAS A BUG HERE TODO
            } else {
              return Text("دیتایی موجود نیست");
            }
          } else {
            return SpinKitChasingDots(
              size: 40,
              color: Theme.of(context).accentColor,
            );
          }
          //return Text("مشکلی پیش آمد");
        },
      ),
    );
  }
}
