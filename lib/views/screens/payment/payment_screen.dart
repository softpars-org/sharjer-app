import 'package:flutter/material.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/payment_api_service.dart';
import 'package:mojtama/views/screens/payment/custompay_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<PaymentModel>(context, listen: false);
    await provider.getCurrentMonth();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("پرداخت شارژ"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadResources(),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Consumer<PaymentModel>(
                  builder: (_, model, child) {
                    return model.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            model.currentMonth,
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
                  onPressed: () async {
                    AppService appService = AppService(context);
                    PaymentProvider paymentProvider = PaymentProvider();
                    var url = await paymentProvider.getChargeUrl();
                    if (url != false && url != "charge_paid") {
                      await launchUrlString(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else if (url == "charge_paid") {
                      appService
                          .snackBar("شما شارژ این ماه را پرداخت کرده‌اید.");
                    } else {
                      appService
                          .snackBar("گرفتن لینک پرداخت شارژ با شکست مواجه شد.");
                    }
                  },
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
