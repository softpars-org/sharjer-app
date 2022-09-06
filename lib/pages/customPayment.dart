import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/pages/payment.dart';
import 'package:mojtama/utils/paymentController.dart';
import 'package:mojtama/utils/util.dart';
import 'package:mojtama/widgets/yearsDrop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mojtama/widgets/customedButton.dart';
import 'package:mojtama/widgets/monthCheckBox.dart';
import 'package:mojtama/widgets/customTextField.dart';

Rx<TextEditingController> description = TextEditingController().obs;

class CustomPayment extends StatelessWidget {
  @override
  PaymentController controller = Get.put(PaymentController());
  bool calculateMonths() {
    if (controller.moharam.value == false &&
        controller.safar.value == false &&
        controller.rabiol1.value == false &&
        controller.rabiol2.value == false &&
        controller.jamadi1.value == false &&
        controller.jamadi2.value == false &&
        controller.rajab.value == false &&
        controller.shaban.value == false &&
        controller.ramezan.value == false &&
        controller.shaval.value == false &&
        controller.zighade.value == false &&
        controller.zilhaje.value == false) {
      return false;
    } else if (controller.moharam.value == true ||
        controller.safar.value == true ||
        controller.rabiol1.value == true ||
        controller.rabiol2.value == true ||
        controller.jamadi1.value == true ||
        controller.jamadi2.value == true ||
        controller.rajab.value == true ||
        controller.shaban.value == true ||
        controller.ramezan.value == true ||
        controller.shaval.value == true ||
        controller.zighade.value == true ||
        controller.zilhaje.value == true) {
      print("something special");
      return true;
    } else {
      return true;
    }
  }

  Widget build(BuildContext context) {
    RxBool descripVal =
        controller.description.value.text == "" ? false.obs : true.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پرداخت شارژ معوقه",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: CustomedTextField(
              label: "توضیحات را وارد کنید",
              style: TextStyleX.style,
              controller: controller.description.value,
              onChanged: (s) {
                if (controller.description.value.text == "") {
                  descripVal.value = false;
                } else {
                  descripVal.value = true;
                }
              },
              maxLines: 8,
            ),
          ),
          MonthCheckBoxes(),
          YearsDropDownButton(),
          Container(
            margin: EdgeInsets.all(40),
            child: Obx(
              () => CustomedButton(
                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                child: Text("پرداخت"),
                onPressed: descripVal.value == true
                    ? () async {
                        if (calculateMonths()) {
                          // var url = await controller.getCustomUrl(
                          //     controller.description.value.text,
                          //     controller.year.value,
                          //     controller.months);
                          // print(url);
                          // launch(url);
                        }
                        print(controller.description.value.text);
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
