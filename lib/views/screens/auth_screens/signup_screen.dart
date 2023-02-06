
import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/plak_model.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/screens/profile_screen.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/plakinput_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameTxt = TextEditingController();
  TextEditingController familyTxt = TextEditingController();
  TextEditingController familyMembersTxt = TextEditingController();

  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController plakTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController phone2Txt = TextEditingController();
  TextEditingController bluckTxt = TextEditingController();
  TextEditingController vahedTxt = TextEditingController();
  TextEditingController startdateTxt = TextEditingController();
  TextEditingController enddateTxt = TextEditingController();
  ProfileHelper profileHelper = ProfileHelper();
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("صفحه ثبت نام"),
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
                      suffixIcon: const Icon(Icons.person_outline),
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
                      suffixIcon: const Icon(Icons.person_outline),
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
                      suffixIcon: const Icon(Icons.person_pin_outlined),
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
                      suffixIcon: const Icon(Icons.group_outlined),
                      helper: "",
                      controller: familyMembersTxt,
                      validator: profileHelper.isNotNull,
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
                      suffixIcon: const Icon(Icons.phone),
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
                      suffixIcon: const Icon(Icons.phone),
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
                      controller: bluckTxt,
                      label: "بلوک",
                      suffixIcon: const Icon(Icons.domain_outlined),
                      keyboardType: TextInputType.number,
                      validator: profileHelper.isNotNull,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: vahedTxt,
                      label: "واحد",
                      suffixIcon: const Icon(Icons.account_balance_outlined),
                      keyboardType: TextInputType.number,
                      validator: profileHelper.isNotNull,
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
                      suffixIcon: const Icon(Icons.date_range_outlined),
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
                      suffixIcon: const Icon(Icons.date_range_outlined),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: passwordTxt,
                validator: profileHelper.isNotNull,
                label: "گذرواژه",
                helper: "گذرواژهٔ خود را وارد کنید",
                obscureText: true,
              ),
            ),
            PlakInputWidget(
              numValidator: profileHelper.isNotNull,
              farsiValidator: profileHelper.checkFarsi,
            ),
            const OwnerStatusCheckbox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () async {
                  AppService appService = AppService(context);
                  bool validated = _formKey.currentState!.validate();
                  if (validated) {
                    CheckboxModel checkModel =
                        Provider.of<CheckboxModel>(context, listen: false);
                    PlakModel plakModel =
                        Provider.of<PlakModel>(context, listen: false);
                    String name = nameTxt.text;
                    String family = familyTxt.text;
                    String username = usernameTxt.text;
                    String password = passwordTxt.text;
                    int familyMembers = int.parse(familyMembersTxt.text);
                    String phone1 = phoneTxt.text;
                    String phone2 = phone2Txt.text;
                    bool isOwner = checkModel.isOwner;
                    String carPlate = plakModel.carPlate;
                    int bluck = int.parse(bluckTxt.text);
                    int vahed = int.parse(vahedTxt.text);
                    String startDate = startdateTxt.text;
                    String endDate = enddateTxt.text;
                    User user = User(
                      username,
                      password,
                      name,
                      family,
                      phone1,
                      phone2,
                      bluck,
                      vahed,
                      familyMembers,
                      carPlate,
                      startDate,
                      endDate,
                      "", //we never use userType. that's why we set a null value into String
                      isOwner ? 1 : 0,
                    );
                    int isSignedUp = await userProvider.signup(user);
                    String snackbarMessage = "";
                    if (isSignedUp == 1) {
                      appService.navigateReplaceNamed("/home");
                      snackbarMessage = "ثبت نام با موفقیت انجام شد!";
                      appService.snackBar(snackbarMessage);
                      appService.navigateReplaceNamed("/home");
                      return;
                    } else if (isSignedUp == -1) {
                      snackbarMessage = "کاربر در پایگاه داده موجود است!";
                    } else {
                      snackbarMessage = "مشکلی پیش آمده است.";
                    }
                    appService.snackBar(snackbarMessage);
                  } else {
                    appService.snackBar("مقادیر را درست و کامل وارد کنید.");
                  }
                },
                text: "ثبت نام",
                icon: Icons.sign_language_sharp,
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
