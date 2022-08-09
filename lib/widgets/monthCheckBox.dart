import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/utils/util.dart';

class MonthCheckBoxes extends StatelessWidget {
  @override
  PaymentController controller = Get.find();
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height,
      //
      //width: Get.width,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.moharam.value,
                        onChanged: (s) {
                          controller.moharam.value = s!;
                          if (s) {
                            controller.months.add('محرم');
                          } else {
                            controller.months.remove("محرم");
                          }
                        },
                        title: Text("محرم"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 5,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.safar.value,
                        onChanged: (s) {
                          controller.safar.value = s!;
                          if (s) {
                            controller.months.add('صفر');
                          } else {
                            controller.months.remove("صفر");
                          }
                        },
                        title: Text("صفر"),
                      ),
                    ),
                  ),
                ],
              ),
            ), //2 checkboxes is implemented by this Row.
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.rabiol1.value,
                        onChanged: (s) {
                          controller.rabiol1.value = s!;
                          if (s) {
                            controller.months.add('ربیع الاول');
                          } else {
                            controller.months.remove("ربیع الاول");
                          }
                        },
                        title: Text("ربیع‌الاول"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.rabiol2.value,
                        onChanged: (s) {
                          controller.rabiol2.value = s!;
                          if (s) {
                            controller.months.add('ربیع الثانی');
                          } else {
                            controller.months.remove("ربیع الثانی");
                          }
                        },
                        title: Text("ربیع‌الثانی"),
                      ),
                    ),
                  ),
                ], //2 checkboxes is implemented by this Row.
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.jamadi1.value,
                        onChanged: (s) {
                          controller.jamadi1.value = s!;
                          if (s) {
                            controller.months.add('جمادی الاول');
                          } else {
                            controller.months.remove("جمادی الاول");
                          }
                        },
                        title: Text("جمادی‌الاول"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.jamadi2.value,
                        onChanged: (s) {
                          controller.jamadi2.value = s!;
                          if (s) {
                            controller.months.add('جمادی الثانی');
                          } else {
                            controller.months.remove("جمادی الثانی");
                          }
                        },
                        title: Text("جمادی‌الثانی"),
                      ),
                    ),
                  ),
                ], //2 checkboxes is implemented by this Row.
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.rajab.value,
                        onChanged: (s) {
                          controller.rajab.value = s!;
                          if (s) {
                            controller.months.add('رجب');
                          } else {
                            controller.months.remove("رجب");
                          }
                        },
                        title: Text("رجب"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.shaban.value,
                        onChanged: (s) {
                          controller.shaban.value = s!;
                          if (s) {
                            controller.months.add('شعبان');
                          } else {
                            controller.months.remove("شعبان");
                          }
                        },
                        title: Text("شعبان"),
                      ),
                    ),
                  ),
                ], //2 checkboxes is implemented by this Row.
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.ramezan.value,
                        onChanged: (s) {
                          controller.ramezan.value = s!;
                          if (s) {
                            controller.months.add('رمضان');
                          } else {
                            controller.months.remove("رمضان");
                          }
                        },
                        title: Text("رمضان"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.shaval.value,
                        onChanged: (s) {
                          controller.shaval.value = s!;
                          if (s) {
                            controller.months.add('شوال');
                          } else {
                            controller.months.remove("شوال");
                          }
                        },
                        title: Text("شوال"),
                      ),
                    ),
                  ),
                ], //2 checkboxes is implemented by this Row.
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.zighade.value,
                        onChanged: (s) {
                          controller.zighade.value = s!;
                          if (s) {
                            controller.months.add('ذی القعده');
                          } else {
                            controller.months.remove("ذی القعده");
                          }
                        },
                        title: Text("ذی‌القعده"),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    //width: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        value: controller.zilhaje.value,
                        onChanged: (s) {
                          controller.zilhaje.value = s!;
                          if (s) {
                            controller.months.add('ذی الحجه');
                          } else {
                            controller.months.remove("ذی الحجه");
                          }
                        },
                        title: Text("ذی‌الحجه"),
                      ),
                    ),
                  ),
                ], //2 checkboxes is implemented by this Row.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
