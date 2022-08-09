import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mojtama/utils/util.dart';

class YearsDropDownButton extends StatelessWidget {
  @override
  RxString dropDownValue = '1443'.obs;
  RxString valuesList = '[]'.obs;
  PaymentController controller = Get.find();
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("سال شارژ: "),
          FutureBuilder(
            future: Functions.getDatabaseYears(),
            builder: (cnx, snapshot) {
              valuesList.value = jsonEncode(snapshot.data);
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  dropDownValue.value = snapshot.data[0].toString();
                  controller.year.value = dropDownValue.value;
                  return Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropDownValue.value,
                        items: List.generate(
                          snapshot.data.length,
                          (index) => DropdownMenuItem(
                            value: snapshot.data[index].toString(),
                            child: Text(
                              snapshot.data[index].toString(),
                            ),
                          ),
                        ),
                        onChanged: (dynamic ans) {
                          dropDownValue.value = ans;
                          controller.year.value = ans;
                        },
                        //   (e) => DropdownMenuItem(
                        //     child: Text(items.toString()),
                        //   ),
                        // ),
                      ),
                    ),
                  );
                } else {
                  return SpinKitChasingDots(
                    color: Theme.of(context).accentColor,
                    size: 35,
                  );
                }
              } else {
                return Text("مشکلی پیش آمد.");
              }
            },
          ),
        ],
      ),
    );
  }
}
