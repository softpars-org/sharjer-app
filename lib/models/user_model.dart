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
      decodedJson["bluck"] as int,
      decodedJson["vahed"] as int,
      decodedJson["family_members"] as int,
      decodedJson["car_plate"],
      decodedJson["startdate"],
      decodedJson["enddate"],
      decodedJson["is_admin"],
      decodedJson["is_owner"] as int,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      "username": user.username,
      "password": user.password,
      "name": user.name,
      "family": user.family,
      "phone": user.phone,
      "phone2": user.phone2,
      "bluck": user.bluck,
      "vahed": user.vahed,
      "family_members": user.familyMembers,
      "car_plate": user.carPlate,
      "startdate": user.startDate,
      "enddate": user.endDate,
      "is_admin": user.userType,
      "is_owner": user.isOwner,
    };
  }
}
