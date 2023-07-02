import 'package:flutter/material.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/user_api_service.dart';

//this model is used for controlling permission state
//which may show admin panel button or hide it.
class PermissionModel extends ChangeNotifier {
  String userPermissionType = "no";
  late User userInfo;
  bool isLoading = false;
  UserProvider userProvider = UserProvider();
  fetchUserType() async {
    var fetchedUserPermission = await userProvider.getMyPermission();
    userPermissionType = fetchedUserPermission;
    notifyListeners();
  }

  fetchUser() async {
    toggleLoading();
    var fetchedUser = await userProvider.getMyProfile();
    toggleLoading();
    if (fetchedUser == false) {
      return;
    }
    userInfo = fetchedUser;
    notifyListeners();
    return userInfo;
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
