import 'dart:convert';

class ChargeRowStatus {
  String year;
  List<String> months;
  List<dynamic> prices;
  ChargeRowStatus(
    this.year,
    this.months,
    this.prices,
  );
  factory ChargeRowStatus.fromJson(Map<String, dynamic> decodedJson) {
    return ChargeRowStatus(
      decodedJson.keys.first,
      decodedJson.values.first.keys.toList(),
      decodedJson.values.first.values.toList(),
    );
  }
}
