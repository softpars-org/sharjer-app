import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:mojtama/views/widgets/year_dropdown_widget.dart';

class ChangeWholeMonthsScreen extends StatelessWidget {
  ChangeWholeMonthsScreen({super.key});
  ProfileHelper helper = ProfileHelper();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغییر ماه‌های شارژ"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () {},
                text: "لیست مبالغ شارژ",
                icon: Icons.list,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "محرم",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "صفر",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
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
                      label: "ربیع الاول",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "ربیع الثانی",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
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
                      label: "جمادی الاول",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "جمادی الثانی",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
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
                      label: "رجب",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "شعبان",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
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
                      label: "رمضان",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "شوال",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
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
                      label: "ذیحجه",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "ذیقعده",
                      keyboardType: TextInputType.number,
                      validator: helper.isNonNullNumber,
                    ),
                  ),
                ),
              ],
            ),
            YearDropDownWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.check_rounded),
      ),
    );
  }
}
