import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/pages/chargeAdder.dart';
import 'package:mojtama/pages/customPayment.dart';
import 'package:mojtama/utils/paymentController.dart';

import 'package:mojtama/widgets/customTextField.dart';

class CustomedPayment2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentController controller = Get.find();
    RxBool visible = true.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "شارژ معوقه",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          tooltip: "برگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.ymd.length,
          itemBuilder: (context, index) {
            visible.value = index > 0;
            return ChargeMonth(
              year: controller.ymd[index][0].toString(),
              month: controller.ymd[index][1].toString(),
              description: controller.ymd[index][2].toString(),
              index: index,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (cnx) => ChargeAdder(),
                ),
              );
            },
            tooltip: "اضافه کردن تاریخ جدید",
            child: Icon(Icons.add),
            heroTag: null,
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: visible.value,
            child: FloatingActionButton(
              onPressed: () {
                print(visible.value);
                var js = json.encode(controller.ymd);
                controller.getCustomUrl(js);
                print(json.encode(controller.ymd));
              },
              tooltip: "پرداخت",
              heroTag: null,
              child: Icon(Icons.payment),
            ),
          ),
        ],
      ),
    );
  }
}

class ChargeMonth extends StatelessWidget {
  @override
  String? year;
  String? month;
  int? index;
  String? description;
  ChargeMonth({this.year, this.month, this.description, this.index});
  Widget build(BuildContext context) {
    PaymentController controller = Get.find();
    return Container(
      padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 23,
                offset: Offset(0, 3),
                color: Theme.of(context).accentColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                print("asdasd");
              },
              onLongPress: () {
                controller.ymd.removeAt(index!); //im here
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("سال: $year"),
                    Text("ماه‌ها: " +
                        jsonDecode(month!)
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", "")),
                    Text("توضیحات شارژ: $description"),
                  ],
                ),
              ),
            ),
          ), // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: CustomedTextFormField(
          //     label: "توضیحات شارژ را وارد کنید.",
          //   ),
          // ),
        ),
      ),
    );
  }
}
