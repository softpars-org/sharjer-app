import 'package:flutter/material.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:provider/provider.dart';

class MonthsCheckBox extends StatelessWidget {
  const MonthsCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MonthsModel>(builder: (context, model, child) {
      return ListView(
        shrinkWrap: true,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: MonthCheckBox(
                    name: "محرم",
                    value: model.months.containsValue("محرم"),
                    onChanged: (newVal) {
                      String month = "محرم";

                      newVal! ? model.add(month) : model.remove(month);
                    },
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: MonthCheckBox(
                    name: "صفر",
                    value: model.months.containsValue("صفر"),
                    onChanged: (newVal) {
                      String month = "صفر";

                      newVal! ? model.add(month) : model.remove(month);
                    },
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: MonthCheckBox(
                    name: "ربیع الاول",
                    value: model.months.containsValue("ربیع الاول"),
                    onChanged: (newVal) {
                      String month = "ربیع الاول";

                      newVal! ? model.add(month) : model.remove(month);
                    },
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: MonthCheckBox(
                    name: "ربیع الثانی",
                    value: model.months.containsValue("ربیع الثانی"),
                    onChanged: (newVal) {
                      String month = "ربیع الثانی";

                      newVal! ? model.add(month) : model.remove(month);
                    },
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: MonthCheckBox(
                    name: "جمادی الاول",
                    value: model.months.containsValue("جمادی الاول"),
                    onChanged: (newVal) {
                      String month = "جمادی الاول";

                      newVal! ? model.add(month) : model.remove(month);
                    },
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                    child: MonthCheckBox(
                  name: "جمادی الثانی",
                  value: model.months.containsValue("جمادی الثانی"),
                  onChanged: (newVal) {
                    String month = "جمادی الثانی";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                    child: MonthCheckBox(
                  name: "رجب",
                  value: model.months.containsValue("رجب"),
                  onChanged: (newVal) {
                    String month = "رجب";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
                const VerticalDivider(),
                Expanded(
                    child: MonthCheckBox(
                  name: "شعبان",
                  value: model.months.containsValue("شعبان"),
                  onChanged: (newVal) {
                    String month = "شعبان";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                    child: MonthCheckBox(
                  name: "رمضان",
                  value: model.months.containsValue("رمضان"),
                  onChanged: (newVal) {
                    String month = "رمضان";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
                const VerticalDivider(),
                Expanded(
                    child: MonthCheckBox(
                  name: "شوال",
                  value: model.months.containsValue("شوال"),
                  onChanged: (newVal) {
                    String month = "شوال";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                    child: MonthCheckBox(
                  name: "ذیقعده",
                  value: model.months.containsValue("ذیقعده"),
                  onChanged: (newVal) {
                    String month = "ذیقعده";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
                const VerticalDivider(),
                Expanded(
                    child: MonthCheckBox(
                  name: "ذیحجه",
                  value: model.months.containsValue("ذیحجه"),
                  onChanged: (newVal) {
                    String month = "ذیحجه";

                    newVal! ? model.add(month) : model.remove(month);
                  },
                )),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class MonthCheckBox extends StatelessWidget {
  String? name;
  bool value;
  void Function(bool?)? onChanged;
  MonthCheckBox({
    super.key,
    this.name = '',
    this.value = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onChanged: onChanged,
      title: Text(name!),
    );
  }
}
