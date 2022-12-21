import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/payment/add_months_screen.dart';
import 'package:mojtama/views/widgets/months_checkbox_widget.dart';
import 'package:provider/provider.dart';

class CustomPayPage extends StatefulWidget {
  const CustomPayPage({super.key});

  @override
  State<CustomPayPage> createState() => _CustomPayPageState();
}

class _CustomPayPageState extends State<CustomPayPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("شارژ معوقه"),
      ),
      body: Consumer<MonthsModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.yearMonthsDetails.length,
            itemBuilder: (context, index) => FadeTransition(
              opacity: _animationController,
              child: CartShower(
                model: model,
                index: index,
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.small(
              heroTag: null,
              onPressed: () {
                AppService appService = AppService(context);
                appService.navigate(AddMonthsPage());
              },
              tooltip: "اضافه کردن ماه‌های جدید",
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: null,
              tooltip: "پرداخت",
              child: Icon(Icons.payment),
            ),
          ),
        ],
      ),
    );
  }
}

class CartShower extends StatelessWidget {
  MonthsModel model;
  int index;
  CartShower({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
                  child: Text("سال: ${model.yearMonthsDetails[index][0]}\n" +
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
