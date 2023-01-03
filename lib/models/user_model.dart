import 'dart:convert';

class User {
  String username;
  String password;
  String name;
  String family;
  String phone;
  String phone2;
  int bluck;
  int vahed;
  int familyMembers;
  String carPlate;
  String startDate;
  String? endDate;
  String userType;
  int isOwner;
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

  factory User.fromJson(Map<String, dynamic> decodedJson) {
    // not completed!
    return User(
      decodedJson["username"],
      decodedJson["password"],
      decodedJson["name"],
      decodedJson["family"],
      decodedJson["phone"],
      decodedJson["phone2"],
      int.parse(decodedJson["bluck"]),
      int.parse(decodedJson["vahed"]),
      int.parse(decodedJson["family_members"]),
      decodedJson["car_plate"],
      decodedJson["startdate"],
      decodedJson["enddate"],
      decodedJson["is_admin"],
      int.parse(decodedJson["is_owner"]),
    );
  }
}
