import 'package:flutter/material.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/user_api_service.dart';

//this model is used for controlling permission state
//which may show admin panel button or hide it.
class PermissionModel extends ChangeNotifier {
  String userPermissionType = "no";
  UserProvider userProvider = UserProvider();
  fetchUserType() async {
    var fetchedUserPermission = await userProvider.getMyPermission();
    userPermissionType = fetchedUserPermission;
    notifyListeners();
  }
}
