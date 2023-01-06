import 'package:flutter/material.dart';
import 'package:mojtama/models/history_model.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/views/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<PaymentModel>(context, listen: false);
    await provider.getPaymentHistory();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("آخرین پرداختی‌های شارژ"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadResources(),
        child: Consumer<PaymentModel>(builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.paymentHistory.length,
            itemBuilder: (_, index) => CustomCard(
                history: model.paymentHistory[index]
                // name: "محمدمهدی بنیادی",
                // content:
                //     "محمدمهدی بنیادی بلوک ۱ واحد ۱۳ شارژ ماه ربیع الثانی را پرداخت کرد.",
                // date: "1401/2/1",
                ),
          );
        }),
      ),
    );
  }
}
