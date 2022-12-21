import 'package:flutter/material.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/payment/custompay_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> onRefreshFunction() async {
      Provider.of<PaymentModel>(context, listen: false).randomText();
      print(Provider.of<PaymentModel>(context, listen: false).text);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("پرداخت شارژ"),
      ),
      body: RefreshIndicator(
        onRefresh: onRefreshFunction,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Consumer<PaymentModel>(
                  builder: (context, model, child) {
                    return Text(
                      model.text,
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  text: "پرداخت شارژ",
                  icon: Icons.credit_card,
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    AppService appService = AppService(context);
                    appService.navigate(CustomPayPage());
                  },
                  child: Text("پرداخت شارژ معوقه"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
