import 'package:flutter/material.dart';

class CustomedAppBar extends StatelessWidget with PreferredSizeWidget {
  String? title;
  CustomedAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
