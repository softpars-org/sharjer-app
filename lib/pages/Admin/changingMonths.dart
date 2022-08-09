import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/pages/settings.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/customTextField.dart';

class ChangingMonths extends StatelessWidget {
  @override
  PaymentController controller = Get.find();
  TextEditingController moharam = TextEditingController();
  TextEditingController safar = TextEditingController();
  TextEditingController rabi1 = TextEditingController();
  TextEditingController rabi2 = TextEditingController();
  TextEditingController jamadi1 = TextEditingController();
  TextEditingController jamadi2 = TextEditingController();
  TextEditingController rajab = TextEditingController();
  TextEditingController shaban = TextEditingController();
  TextEditingController ramezan = TextEditingController();
  TextEditingController shaval = TextEditingController();
  TextEditingController zighade = TextEditingController();
  TextEditingController zihaje = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تغییر مبلغ ماه‌ها",
          style: TextStyle(color: Get.theme.accentColor),
        ),
        leading: IconButton(
          color: Get.theme.accentColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2),
            child: Text("سال: "),
          ),
          Padding(
            child: YearDropDown(
              controller: controller,
            ),
            padding: EdgeInsets.all(8),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "مبلغ را در فیلدها به تومان وارد کنید.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "محرم",
                    controller: moharam,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "صفر",
                    controller: safar,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "ربیع الاول",
                    controller: rabi1,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "ربیع الثانی",
                    controller: rabi2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "جمادی الاول",
                    controller: jamadi1,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "جمادی الثانی",
                    controller: jamadi2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "رجب",
                    controller: rajab,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "شعبان",
                    controller: shaban,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "رمضان",
                    controller: ramezan,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "شوال",
                    controller: shaval,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "ذی القعده",
                    controller: zighade,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomedTextField(
                    label: "ذی الحجه",
                    controller: zihaje,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class YearDropDown extends StatelessWidget {
  @override
  PaymentController? controller;
  YearDropDown({this.controller});
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => DropdownButton(
          value: controller!.year.value,
          underline: Container(
            height: 2,
            color: Get.theme.accentColor,
          ),
          onChanged: (dynamic changed) {
            controller!.year.value = changed;
          },
          items: [
            "1430",
            "1431",
            "1432",
            "1433",
            "1434",
            "1435",
            "1436",
            "1437",
            "1438",
            "1439",
            "1440",
            "1441",
            "1442",
            "1443",
            "1444",
            "1445",
            "1446",
            "1447",
            "1448",
            "1449",
            "1450",
            "1451",
            "1452"
          ]
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
        ),
      ),
    );
  }
}
