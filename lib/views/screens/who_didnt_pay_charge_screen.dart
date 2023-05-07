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
    return ChangeNotifierProvider(
      create: (context) => WhoDidntPayChargeModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("افراد پرداخت نکرده شارژ"),
        ),
        body: Consumer<WhoDidntPayChargeModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: !model.isLoading,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Text("jello");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
