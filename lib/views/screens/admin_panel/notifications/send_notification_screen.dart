import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mojtama/helpers/profile_helper.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class SendNotificationScreen extends StatelessWidget {
  SendNotificationScreen({super.key});
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ارسال اعلان"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: title,
                label: "عنوان",
                suffixIcon: Icon(Icons.title),
                validator: ProfileHelper().checkNullCharacterValue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: body,
                maxLines: 5,
                label: "متن اعلان",
                suffixIcon: Icon(Icons.text_fields_outlined),
                validator: ProfileHelper().checkNullCharacterValue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isOk = _formKey.currentState!.validate();
          if (isOk) {
            AppService appService = AppService(context);
            AdminProvider adminProvider = AdminProvider();
            bool isNotifSent =
                await adminProvider.sendNotif(title.text, body.text);
            if (isNotifSent) {
              appService.snackBar("اعلان به کاربران ارسال شد.");
            } else {
              appService.snackBar("ارسال اعلان با مشکلی مواجه شد.");
            }
          }
        },
        child: Icon(Icons.check_rounded),
      ),
    );
  }
}
