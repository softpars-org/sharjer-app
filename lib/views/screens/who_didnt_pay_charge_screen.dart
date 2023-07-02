import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/who_didnt_pay_model.dart';
import 'package:provider/provider.dart';

class WhoDidntPayChargeScreen extends StatefulWidget {
  const WhoDidntPayChargeScreen({super.key});

  @override
  State<WhoDidntPayChargeScreen> createState() =>
      _WhoDidntPayChargeScreenState();
}

class _WhoDidntPayChargeScreenState extends State<WhoDidntPayChargeScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var provider = Provider.of<WhoDidntPayChargeModel>(context, listen: false);
    Future.delayed(Duration.zero, () => provider.fetchPeopleWhoDidntPay());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("افراد پرداخت نکرده شارژ"),
      ),
      body: Consumer<WhoDidntPayChargeModel>(
        builder: (context, model, child) {
          return Visibility(
            visible: !model.isLoading,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: model.users.keys.length,
              itemBuilder: (context, index) {
                String bluckNumber = model.users.keys.elementAt(index);
                String users = model.users.values.elementAt(index).join("\n");
                return UsersWhoDidntPay(bluckNumber: bluckNumber, users: users);
              },
            ),
          );
        },
      ),
    );
  }
}

class UsersWhoDidntPay extends StatelessWidget {
  final String bluckNumber;
  final String users;
  const UsersWhoDidntPay({
    super.key,
    required this.bluckNumber,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "پرداخت نکرده‌های بلوک$bluckNumber",
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            Text(
              users,
            ),
          ],
        ),
      ),
    );
  }
}
