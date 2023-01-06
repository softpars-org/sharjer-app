import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/months_checkbox_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddMonthsPage extends StatelessWidget {
  const AddMonthsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافه کردن شارژ معوقه"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: MonthsCheckBox(),
          ),
          Divider(
            indent: 5,
            endIndent: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: YearDropDownWidget(),
          ),
        ],
      ),
      floatingActionButton: Consumer<MonthsModel>(
        builder: (_, model, child) {
          return model.months.isEmpty
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
                    var model =
                        Provider.of<MonthsModel>(context, listen: false);
                    var year =
                        Provider.of<YearModel>(context, listen: false).year;

                    var months = model.months;

                    model.yearMonthsDetails.add([year, months.values.toList()]);
                    AppService _appService = AppService(context);
                    _appService.snackBar("شارژ معوقه به لیست اضافه شد.");
                    model.update();
                  },
                  tooltip: "اضافه کردن",
                  child: Icon(Icons.add_card),
                );
        },
      ),
    );
  }
}
