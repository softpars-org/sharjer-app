import 'dart:convert';

class User {
  String? username;
  String? password;
  String? name;
  String? family;
  String? phone;
  String? phone2;
  int? bluck;
  int? vahed;
  int? familyMembers;
  String? carPlate;
  String? startDate;
  String? endDate;
  String? userType;
  int? isOwner;
  User(
    this.username,
    this.password,
    this.name,
    this.family,
    this.phone,
    this.phone2,
    this.bluck,
    this.vahed,
    this.familyMembers,
    this.carPlate,
    this.startDate,
    this.endDate,
    this.userType,
    this.isOwner,
  );

  factory User.fromJson(String json) {
    // not completed!
    Map<String, dynamic> decodedJson = jsonDecode(json);
    return User(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    );
  }
}
