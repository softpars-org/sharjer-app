import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/month_model.dart';
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
        title: const Text("اضافه کردن شارژ معوقه"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: MonthsCheckBox(),
          ),
          const Divider(
            indent: 5,
            endIndent: 5,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
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
                    AppService appService = AppService(context);
                    appService.snackBar("شارژ معوقه به لیست اضافه شد.");
                    model.update();
                  },
                  tooltip: "اضافه کردن",
                  child: const Icon(Icons.add_card),
                );
        },
      ),
    );
  }
}
