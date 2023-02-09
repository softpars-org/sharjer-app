import 'package:flutter/material.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class AdminPanelModel extends ChangeNotifier {
  final List<Widget> _textFieldList = [];
  bool isLoading = false;
  final List<Map<String, TextEditingController>>
      _textEditingControllersMapList = [];
  List<Widget> get textFieldList {
    return _textFieldList;
  }

  List<User> _users = [];
  List<User> _bluck1Users = [];
  List<User> _bluck2Users = [];
  List<User> _bluck3Users = [];
  List<User> get bluck1Users {
    return _bluck1Users;
  }

  List<User> get bluck2Users {
    return _bluck2Users;
  }

  List<User> get bluck3Users {
    return _bluck3Users;
  }

  List<User> get users {
    return _users;
  }

  addTextField() {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    final widget = generateTextField(titleController, priceController);
    _textEditingControllersMapList.add({
      "title": titleController,
      "price": priceController,
    });
    _textFieldList.add(widget);
    notifyListeners();
  }

  Widget generateTextField(
    TextEditingController titleController,
    TextEditingController priceController,
  ) {
    final Widget textField = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "عنوان",
              suffixIcon: const Icon(Icons.title_outlined),
              controller: titleController,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "مبلغ",
              keyboardType: TextInputType.number,
              suffixIcon: const Icon(Icons.price_check_outlined),
              controller: priceController,
            ),
          ),
        )
      ],
    );

    return textField;
  }

  removeTextField() {
    if (_textFieldList.isNotEmpty) {
      _textEditingControllersMapList.removeLast();
      _textFieldList.removeLast();
      notifyListeners();
    }
  }

  generateJsonFromFields() {
    List json = [];
    for (Map textControllersMap in _textEditingControllersMapList) {
      Map manipulatedMap = {
        "title": textControllersMap["title"].text,
        "price": textControllersMap["price"].text,
      };
      json.add(manipulatedMap);
    }
    return json;
  }

  getUsers() async {
    AdminProvider api = AdminProvider();
    toggleLoading();
    var usersInDB = await api.getUsers();
    if (usersInDB != null) {
      _users = usersInDB;
      notifyListeners();
    }
    toggleLoading();
    return _users;
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  getUsersLengthOfBluck(int bluck) {
    int usersLength = 0;
    for (var user in users) {
      if (user.bluck == bluck) {
        usersLength++;
      }
    }
    return usersLength;
  }

  filterUsersByBluck() {
    //TODO: I SHOULD EDIT THE FUNCTION. BUG...
    _bluck1Users = [];
    _bluck2Users = [];
    _bluck3Users = [];
    for (var user in users) {
      if (user.bluck == 1) {
        _bluck1Users.add(user);
      } else if (user.bluck == 2) {
        _bluck2Users.add(user);
      } else if (user.bluck == 3) {
        _bluck3Users.add(user);
      }
    }
    notifyListeners();
  }
}
