import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/payment_model.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/widgets/payment_status_table.dart';
import 'package:provider/provider.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({super.key});

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  String nameFamily = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<PaymentModel>(context, listen: false);
    provider.getChargeStatusOfTheUser();
    UserProvider userProvider = UserProvider();
    var response = await userProvider.getMyProfile();

    //check if successfuly got user information.
    if (response == false) {
      nameFamily = "";
    } else {
      nameFamily = "${response.name} ${response.family}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("وضعیت شارژ"),
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
                      name: nameFamily,
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
