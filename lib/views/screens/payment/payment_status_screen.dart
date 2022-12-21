import 'package:flutter/material.dart';
import 'package:mojtama/views/widgets/payment_status_table.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وضعیت شارژ"),
      ),
      body: ListView(
        children: [
          PaymentStatusTable(),
        ],
      ),
    );
  }
}
