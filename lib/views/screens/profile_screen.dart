import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/models/permission_model.dart';
import 'package:mojtama/models/plak_model.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/widgets/button_widget.dart';
import 'package:mojtama/views/widgets/plakinput_widget.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode nameNode = FocusNode();
  TextEditingController nameTxt = TextEditingController();
  TextEditingController familyTxt = TextEditingController();
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController familyMembersTxt = TextEditingController();
  TextEditingController plakTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController phone2Txt = TextEditingController();
  TextEditingController bluckTxt = TextEditingController();
  TextEditingController vahedTxt = TextEditingController();
  TextEditingController startdateTxt = TextEditingController();
  TextEditingController enddateTxt = TextEditingController();
  ProfileHelper profileHelper = ProfileHelper();
  UserProvider userProvider = UserProvider();
  late PlakModel plakProvider;
  late CheckboxModel checkboxProvider;
  @override
  void initState() {
    Future.delayed(Duration.zero, () => _loadResources());
    plakProvider = Provider.of<PlakModel>(context, listen: false);
    checkboxProvider = Provider.of<CheckboxModel>(context, listen: false);
    super.initState();
  }

  Future<dynamic> _loadResources() async {
    await fetchUserInformation();
  }

  Future<dynamic> fetchUserInformation() async {
    var provider = Provider.of<PermissionModel>(context, listen: false);
    User? user = await provider.fetchUser();
    useUserInformationWeGot(user!);
  }

  useUserInformationWeGot(User user) {
    nameTxt.text = user.name;
    familyTxt.text = user.family;
    usernameTxt.text = user.username;
    familyMembersTxt.text = user.familyMembers.toString();
    phoneTxt.text = user.phone;
    phone2Txt.text = user.phone2;
    bluckTxt.text = user.bluck.toString();
    vahedTxt.text = user.vahed.toString();
    startdateTxt.text = user.startDate;
    enddateTxt.text = user.endDate!;
    plakProvider.setCarPlate(user.carPlate != "" ? user.carPlate : "|||");
  }

  Future<bool> updateProfile() async {
    var box = Hive.box("auth");
    String currentUsername = box.get("username");
    String currentPassword = box.get("password");
    Map<String, dynamic> information = {
      "username": currentUsername,
      "password": currentPassword,
      "new_username": usernameTxt.text,
      "name": nameTxt.text,
      "family": familyTxt.text,
      "family_members": familyMembersTxt.text,
      "phone": phoneTxt.text,
      "phone2": phone2Txt.text,
      "bluck": bluckTxt.text,
      "vahed": vahedTxt.text,
      "startdate": startdateTxt.text,
      "enddate": enddateTxt.text,
      "car_plate": plakProvider.carPlate,
      "is_owner": (checkboxProvider.isOwner ? 1 : 0).toString(),
    };
    bool response = await userProvider.updateInformation(information);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("پروفایل"),
      ),
      body: Form(
        key: _formKey,
        child: RefreshIndicator(
          onRefresh: () => _loadResources(),
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
                        controller: familyMembersTxt,
                        keyboardType: TextInputType.number,
                        label: "تعداد نفرات",
                        suffixIcon: const Icon(Icons.car_repair),
                        helper: "",
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
                        keyboardType: TextInputType.phone,
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
                        keyboardType: TextInputType.phone,
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
              PlakInputWidget(
                numValidator: profileHelper.isNotNull,
                farsiValidator: profileHelper.checkFarsi,
              ),
              const OwnerStatusCheckbox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: () async {
                    bool ok = _formKey.currentState!.validate();
                    if (ok) {
                      bool isUpdated = await updateProfile();
                      if (isUpdated) {
                        AppService(context)
                            .snackBar("پروفایل شما آپدیت گردید.");
                      } else {
                        AppService(context).snackBar("مشکلی پیش آمد!");
                      }
                    }
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
            title: const Text("مالک هستم."),
            value: checkModel.isOwner,
            onChanged: (newValue) {
              checkModel.toggleCheckbox();
            },
          ),
        ));
  }
}
