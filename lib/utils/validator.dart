import 'package:get/get.dart';

class FormController extends GetxController {
  late RxString name, family, username, phone, bluck, vahed, startDate, endDate;
  late RxnString errorText;

  //RxnString errorText = RxnString(null);
  void onInit() {
    super.onInit();
    errorText.value = null;
  }

  generateError(String val) {
    errorText.value = null;
    if (val == "") {
      errorText.value = "فیلد نمی‌تواند خالی باشد.";
    }
  }
}
