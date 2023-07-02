import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/viewmodels/month_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/views/widgets/payment_status_table.dart';
import 'package:provider/provider.dart';

class ShowMonthPricesScreen extends StatefulWidget {
  const ShowMonthPricesScreen({super.key});

  @override
  State<ShowMonthPricesScreen> createState() => _ShowMonthPricesScreenState();
}

class _ShowMonthPricesScreenState extends State<ShowMonthPricesScreen> {
  late AdminProvider adminProvider;
  late YearModel yearProvider;
  late MonthsModel monthsProvider;
  List<String> years = [];
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    adminProvider = AdminProvider();
    yearProvider = Provider.of<YearModel>(context, listen: false);
    monthsProvider = Provider.of<MonthsModel>(context, listen: false);
    Map<String, dynamic> response = await adminProvider.getMonthsPricesInfo();
    print(response);
    monthsProvider.setMonthsPricesValue(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لیست مبالغ شارژ"),
      ),
      body: Consumer2<YearModel, MonthsModel>(
        builder: (context, yearModel, monthModel, child) {
          return ListView.builder(
            itemCount: monthModel.yearMonthsPricesDetails.length,
            //TODO: it has to be completed.
            itemBuilder: (context, index) {
              ChargeRowStatus chargeMonthPrice =
                  monthModel.yearMonthsPricesDetails[index];

              return PaymentStatusTable(
                year: 'year',
                name: "‌",
                chargeStatusOfTheUser: chargeMonthPrice,
              );
            },
          );
        },
      ),
    );
  }
}
