import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/month_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/payment_api_service.dart';
import 'package:mojtama/views/screens/payment/add_months_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomPayPage extends StatefulWidget {
  const CustomPayPage({super.key});

  @override
  State<CustomPayPage> createState() => _CustomPayPageState();
}

class _CustomPayPageState extends State<CustomPayPage> {
  @override
  Widget build(BuildContext context) {
    AppService appService = AppService(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("شارژ معوقه"),
      ),
      body: Consumer<MonthsModel>(
        builder: (_, model, child) {
          return ListView.builder(
            itemCount: model.yearMonthsDetails.length,
            itemBuilder: (__, index) => CartShower(
              model: model,
              index: index,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: SpeedDial(
        direction: SpeedDialDirection.up,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        tooltip: "باز کردن منو...",
        children: [
          SpeedDialChild(
            backgroundColor: Theme.of(context).primaryColor,
            label: "پرداخت",
            onTap: () async {
              PaymentProvider paymentProvider = PaymentProvider();
              var provider = Provider.of<MonthsModel>(context, listen: false);
              String jsonYearMonthsChargeInfo = jsonEncode(
                provider.yearMonthsDetails,
              );
              String response = await paymentProvider
                  .getCustomChargeUrl(jsonYearMonthsChargeInfo);
              if (response == "price shouldn't be 0 Rial") {
                appService.snackBar(
                    "شما شارژهای ماه‌هایی که انتخاب کرده‌اید را پرداخت کرده‌ و یا مبلغ صفر ریال است.");
              } else if (response == "try changing your months") {
                appService.snackBar(
                    "قیمت ماه‌های انتخاب شده شما هنوز توسط مدیر در پایگاه داده اضافه نشده است.");
              } else {
                String url = response;
                await launchUrlString(url,
                    mode: LaunchMode.externalApplication);
              }
            },
            child: Icon(
              Icons.payment,
              color: Theme.of(context).canvasColor,
            ),
          ),
          SpeedDialChild(
            backgroundColor: Theme.of(context).primaryColor,
            label: "اضافه کردن",
            onTap: () {
              appService.navigate(const AddMonthsPage());
            },
            child: Icon(Icons.add_card, color: Theme.of(context).canvasColor),
          ),
        ],
      ),
    );
  }
}

class CartShower extends StatelessWidget {
  final MonthsModel model;
  final int index;
  const CartShower({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onLongPress: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      var model =
                          Provider.of<MonthsModel>(context, listen: false);
                      model.yearMonthsDetails.removeAt(index);
                      model.update();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text("سال: ${model.yearMonthsDetails[index][0]}\n"
                      "ماه‌ها: ${model.yearMonthsDetails[index][1].join('، ')}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
