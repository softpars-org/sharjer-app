import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لیست اعضا",
          style: Get.theme.primaryTextTheme.headline6,
        ),
        leading: IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.arrow_back),
          tooltip: "برگشت",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
