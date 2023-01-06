import 'dart:convert';

class History {
  final String fullName;
  final String date;
  final String message;
  History(this.fullName, this.date, this.message);
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      json["full_name"],
      json["paid_at"],
      json["message"],
    );
  }
}
