import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/month_model.dart';
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
  @override
  void initState() {
    super.initState();
    adminProvider = AdminProvider();
    yearProvider = Provider.of<YearModel>(context, listen: false);
    monthsProvider = Provider.of<MonthsModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لیست مبالغ شارژ"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => PaymentStatusTable(
          year: 'year',
          name: "TESTNAME",
          chargeStatusOfTheUser: ChargeRowStatus(
            '1444',
            monthsProvider.monthsPricesDetails.keys.toList(),
            monthsProvider.monthsPricesDetails.values.toList().cast<int>(),
          ),
        ),
      ),
    );
  }
}
