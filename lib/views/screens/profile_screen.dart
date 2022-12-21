import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/plakinput_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
    FocusNode nameNode = FocusNode();
    TextEditingController nameTxt = TextEditingController();
    TextEditingController familyTxt = TextEditingController();
    TextEditingController usernameTxt = TextEditingController();
    TextEditingController plakTxt = TextEditingController();
    TextEditingController phoneTxt = TextEditingController();
    TextEditingController phone2Txt = TextEditingController();
    TextEditingController bluckTxt = TextEditingController();
    TextEditingController vahedTxt = TextEditingController();
    TextEditingController startdateTxt = TextEditingController();
    TextEditingController enddateTxt = TextEditingController();
    ProfileHelper profileHelper = ProfileHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text("پروفایل"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: nameTxt,
                      label: "نام",
                      suffixIcon: Icon(Icons.person_outline),
                      helper: "به صورت فارسی",
                      validator: profileHelper.checkFarsi,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "نام خانوادگی",
                      controller: familyTxt,
                      validator: profileHelper.checkFarsi,
                      suffixIcon: Icon(Icons.person_outline),
                      helper: "به صورت فارسی",
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
                      label: "نام کاربری",
                      suffixIcon: Icon(Icons.person_pin_outlined),
                      controller: usernameTxt,
                      helper: "به صورت لاتین",
                      validator: profileHelper.checkLatin,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "تعداد نفرات",
                      suffixIcon: Icon(Icons.car_repair),
                      helper: "",
                      controller: usernameTxt,
                      validator: profileHelper.checkFarsi,
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
                      label: "شماره همراه",
                      controller: phoneTxt,
                      validator: profileHelper.checkPhone,
                      suffixIcon: Icon(Icons.phone),
                      helper: "شماره برای ثبت در ریموت",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "شماره همراه ۲",
                      validator: profileHelper.checkPhone,
                      controller: phone2Txt,
                      suffixIcon: Icon(Icons.phone),
                      helper: "شماره برای ثبت در ریموت",
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
                      label: "بلوک",
                      suffixIcon: Icon(Icons.domain_outlined),
                      keyboardType: TextInputType.number,
                      validator: profileHelper.isNonNullNumber,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "واحد",
                      suffixIcon: Icon(Icons.account_balance_outlined),
                      keyboardType: TextInputType.number,
                      validator: profileHelper.isNonNullNumber,
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
                      label: "تاریخ ورود",
                      helper: "تاریخ ورود به مجتمع",
                      controller: startdateTxt,
                      validator: profileHelper.isDate,
                      suffixIcon: Icon(Icons.date_range_outlined),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "تاریخ خروج",
                      controller: enddateTxt,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return profileHelper.isDate(value);
                        } else {
                          return null;
                        }
                      },
                      helper: "تاریخ خروج از مجتمع",
                      suffixIcon: Icon(Icons.date_range_outlined),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
              ],
            ),
            PlakInputWidget(
              numValidator: profileHelper.isNonNullNumber,
              farsiValidator: profileHelper.checkFarsi,
            ),
            OwnerStatusCheckbox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () {
                  bool ok = _formKey.currentState!.validate();
                  if (ok)
                    print("Ok");
                  else
                    print("It's not Ok");
                },
                text: "آپدیت پروفایل",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerStatusCheckbox extends StatelessWidget {
  const OwnerStatusCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<CheckboxModel, ThemeModel>(
          builder: (_, checkModel, themeModel, child) => CheckboxListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text("مالک هستم."),
            value: checkModel.isOwner,
            onChanged: (newValue) {
              themeModel.toggleTheme();
              checkModel.toggleCheckbox();
            },
          ),
        ));
  }
}
