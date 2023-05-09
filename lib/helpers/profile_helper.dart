class ProfileHelper {
  String? checkNullCharacterValue(String? value) {
    if (value!.isEmpty) {
      return "مقدار خالی می‌باشد.";
    }
    return null;
  }

  String? checkFarsi(String? value) {
    if (value!.isEmpty) return "فیلد خالی است!";

    bool isFarsi = value.contains(RegExp(r'[ا-ی]'));
    return isFarsi ? null : "فارسی بنویسید!!";
  }

  String? checkLatin(String? value) {
    if (value!.isEmpty) return "فیلد خالی است!";
    value = value.toLowerCase();
    bool isLatin = value.contains(RegExp(r'[a-z]'));
    return isLatin ? null : "لاتین بنویسید!!";
  }

  String? checkPhone(String? value) {
    if (value!.isEmpty) return "فیلد خالی است!";
    bool isPhone = value.contains(RegExp(r"[0-9]"));
    bool isPatternOk = value.startsWith('09');
    if (isPhone && value.length == 11 && isPatternOk) return null;
    return "الگوی شماره تلفن اشتباه میباشد.";
  }

  String? isNotNull(String? value) {
    if (value!.isEmpty) {
      return "فیلد خالی است!";
    }
    if (int.tryParse(value) == null) {
      return "به صورت عددی وارد کنید";
    }
    return null;
  }

  String? isDate(String? value) {
    if (value!.isEmpty) return "فیلد خالی است!";
    var pattern = r"^(\d)*(\/)(\d)*(\/)(\d)*$";
    if (value.length != 10) {
      return "ده رقمی وارد شود!";
    } else if (value.contains(RegExp(pattern))) {
      return null;
    }

    return "تاریخ به درستی وارد نشده است";
  }
}
