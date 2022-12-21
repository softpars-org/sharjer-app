import 'package:flutter/material.dart';
import 'package:mojtama/views/widgets/card_widget.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("آخرین پرداختی‌های شارژ"),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => CustomCard(
          name: "محمدمهدی بنیادی",
          content:
              "محمدمهدی بنیادی بلوک ۱ واحد ۱۳ شارژ ماه ربیع الثانی را پرداخت کرد.",
          date: "1401/2/1",
        ),
      ),
    );
  }
}
