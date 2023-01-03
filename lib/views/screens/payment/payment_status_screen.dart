import 'package:flutter/material.dart';
import 'package:mojtama/models/charge_status_model.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/views/widgets/payment_status_table.dart';
import 'package:provider/provider.dart';

class PaymentStatusScreen extends StatefulWidget {
  PaymentStatusScreen({super.key});

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  List<ChargeRowStatus> chargeStatusOfTheUser = [
    ChargeRowStatus("1444", ["ربیع", "علی"], ["10000", "20000"]),
    ChargeRowStatus("1444", ["ربیع", "علی"], ["10000", "20000"]),
    ChargeRowStatus("1444", ["ربیع", "حسن"], ["10000", "20000"]),
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<PaymentModel>(context, listen: false);
    provider.getChargeStatusOfTheUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وضعیت شارژ"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadResources(),
        child: Consumer<PaymentModel>(
          builder: (context, model, child) {
            return ListView(
              children: [
                ...List.generate(
                  model.chargeStatusOfTheUser.length,
                  (index) {
                    return PaymentStatusTable(
                      year: "1444",
                      chargeStatusOfTheUser: model.chargeStatusOfTheUser[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
