import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mojtama/pages/adminScreens/change_month.dart';
import 'package:mojtama/utils/functionController.dart';
import 'package:mojtama/widgets/customedAppBar.dart';
import 'package:mojtama/widgets/yearTable.dart';

getKeys(Map map) {
  List? lst = [];
  map.keys.forEach((element) {
    lst.add(element);
  });
  return lst;
}

getValues(Map map) {
  List? lst = [];
  map.values.forEach((element) {
    lst.add(element);
  });
  return lst;
}

class SeeChargePricesPage extends StatelessWidget {
  AdminAPI api = new AdminAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomedAppBar(
        title: "لیست مبالغ",
      ),
      body: ListPricesFutureBuilder(
        api: api,
      ),
    );
  }
}

class ListPricesFutureBuilder extends StatelessWidget {
  const ListPricesFutureBuilder({
    Key? key,
    required this.api,
  }) : super(key: key);

  final AdminAPI api;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getMonthPrices(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: getKeys(
              snapshot.data,
            ).length, //keys length of response data
            itemBuilder: (_, i) {
              return ListOfPrices(
                year: getKeys(snapshot.data)[i], //select year from JSON
                json: snapshot.data, //pass json to json value in another Class.
              );
            },
          );
        } else {
          return Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).accentColor,
            ),
          );
        }
      },
    );
  }
}

class ListOfPrices extends StatelessWidget {
  String? year;
  Map? json;
  ListOfPrices({Key? key, this.year, this.json}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "سال: $year",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            children: List.generate(
              json![year].length,
              (index) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getKeys(json![year])[index].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getValues(json![year])[index].toString()),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
