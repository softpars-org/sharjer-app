import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mojtama/pages/Admin/change_month.dart';
import 'package:mojtama/utils/util.dart';

class MonthRadioBoxes extends StatelessWidget {
  @override
  PaymentController controller = Get.find();
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 1,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("محرم"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 2,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("صفر"),
                    ),
                  ),
                )
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 3,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("ربیع الاول"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 4,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("ربیع الثانی"),
                    ),
                  ),
                )
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 5,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("جمادی الاول"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 6,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("جمادی الثانی"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 7,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("رجب"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 8,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("شعبان"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 9,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("رمضان"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 10,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("شوال"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 11,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("ذی‌القعده"),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: 12,
                      groupValue: controller.groupValue.value,
                      onChanged: (dynamic value) {
                        controller.groupValue.value = value;
                      },
                      title: Text("ذی‌الحجه"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
