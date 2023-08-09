import 'package:flutter/material.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class ChangeYearScreen extends StatefulWidget {
  const ChangeYearScreen({super.key});

  @override
  State<ChangeYearScreen> createState() => _ChangeYearScreenState();
}

class _ChangeYearScreenState extends State<ChangeYearScreen> {
  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final ProfileHelper helper = ProfileHelper();
  final UserProvider _userProvider = UserProvider();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    int? year = await _userProvider.getYear();
    String yearString = (year ?? 0).toString();
    yearController.text = yearString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغییر سال شارژ"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
              child: CustomTextField(
                label: "سال جدید شارژ را وارد کنید",
                controller: yearController,
                suffixIcon: const Icon(Icons.date_range_outlined),
                helper: "",
                keyboardType: TextInputType.number,
                validator: helper.isNotNull,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isOk = _key.currentState!.validate();
          if (isOk) {
            AdminProvider api = AdminProvider();
            bool isYearUpdated = await api.updateYear(yearController.text);
            final AppService appService = AppService(context);
            if (isYearUpdated) {
              appService.snackBar("سال شارژ با موفقیت تغییر کرد.");
            } else {
              appService.snackBar("مشکلی در سمت سرور پیش آمد.");
            }
          }
        },
        tooltip: "تغییر سال شارژ",
        child: const Icon(Icons.change_circle_rounded),
      ),
    );
  }
}
