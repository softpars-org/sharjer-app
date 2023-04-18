import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/admin_panel/change_month/show_month_prices.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';
import 'package:provider/provider.dart';

class ChangeWholeMonthsScreen extends StatefulWidget {
  const ChangeWholeMonthsScreen({super.key});

  @override
  State<ChangeWholeMonthsScreen> createState() =>
      _ChangeWholeMonthsScreenState();
}

class _ChangeWholeMonthsScreenState extends State<ChangeWholeMonthsScreen> {
  ProfileHelper helper = ProfileHelper();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [];
  Map<String, int> monthsPricesDetails = {};
  late AdminProvider adminProvider;
  late YearModel yearProvider;
  late MonthsModel monthsProvider;
  @override
  void initState() {
    super.initState();
    yearProvider = Provider.of<YearModel>(context, listen: false);
    monthsProvider = Provider.of<MonthsModel>(context, listen: false);
    adminProvider = AdminProvider();
    _generateTextControllers();
    Future.delayed(Duration.zero, () => _loadMonthsPrice());
  }

  // _castResponse(Map<String, dynamic> response) {
  //   Map<String, int> castedResponse = {};
  //   response.forEach((key, value) {
  //     castedResponse.addAll()
  //   });
  // }

  _loadMonthsPrice() async {
    AdminProvider adminProvider = AdminProvider();
    String year = yearProvider.year;
    List<String> monthsStrings = monthsProvider.monthsStrings;
    Map<String, dynamic> response = await adminProvider.getMonthsPricesInfo();
    int i = 0;

    for (var monthController in _controllers) {
      String month = monthsStrings[i];
      //validate year and month in response
      bool validation =
          ((response.containsKey(year)) && (response[year].containsKey(month)));
      if (validation) {
        //set price for the appropriate month controller.

        String priceByToman =
            ((response[year][month] ?? 0) / 10).toInt().toString();
        monthController.text = priceByToman;
      } else {
        //set 0 for monthController when there is no data from server side.
        monthController.text = "0";
      }
      i++;
    }
  }

  @override
  _generateTextControllers() {
    for (int i = 0; i < 12; i++) {
      _controllers.add(TextEditingController(text: "0"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغییر ماه‌های شارژ"),
      ),
      body: Form(
        key: _key,
        child: RefreshIndicator(
          onRefresh: () => _loadMonthsPrice(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: () {
                    AppService appService = AppService(context);
                    appService.navigate(const ShowMonthPricesScreen());
                  },
                  text: "لیست مبالغ شارژ",
                  icon: Icons.list,
                ),
              ),
              Column(
                children: [
                  Text("به ریال مبالغ را وارد کنید."),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).hintColor,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[0],
                        label: "محرم",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[1],
                        label: "صفر",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[2],
                        label: "ربیع الاول",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[3],
                        label: "ربیع الثانی",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[4],
                        label: "جمادی الاول",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[5],
                        label: "جمادی الثانی",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[6],
                        label: "رجب",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[7],
                        label: "شعبان",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[8],
                        label: "رمضان",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[9],
                        label: "شوال",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[10],
                        label: "ذیحجه",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _controllers[11],
                        label: "ذیقعده",
                        keyboardType: TextInputType.number,
                        validator: helper.isNotNull,
                      ),
                    ),
                  ),
                ],
              ),
              const YearDropDownWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String year = yearProvider.year;
          List<String> monthsStrings = monthsProvider.monthsStrings;

          int i = 0;
          for (TextEditingController monthController in _controllers) {
            String month = monthsStrings[i];
            if (monthController.text != "0") {
              int? price = int.tryParse(monthController.text);
              if (price == null) continue;
              int priceByRial = (price * 10);
              monthsPricesDetails[month] = priceByRial;
            }
            i++;
          }
          await adminProvider.changeMonthsPriceOfYear(
            year,
            monthsPricesDetails,
          );
          AppService(context).snackBar("مبالغ با موفقیت اعمال شدند!");
        },
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
