import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppService {
  BuildContext context;
  AppService(this.context);
  navigateNamed(String pageName) {
    Navigator.pushNamed(
      context,
      pageName,
    );
  }

  navigateReplaceNamed(String pageName) {
    Navigator.pushReplacementNamed(
      context,
      pageName,
    );
  }

  navigateWithNav(Widget page) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: page,
      withNavBar: true,
    );
  }

  navigate(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: page,
        ),
      ),
    );
  }

  navigateReplace(Widget page) {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: page,
        ),
      ),
    );
  }

  snackBar(String text) {
    SnackBar snackbar = SnackBar(
      content: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(Icons.info),
          ),
          Expanded(child: SizedBox(width: 10)),
          Expanded(
            flex: 9,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'VazirLight',
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  deleteAuthBox() {
    var box = Hive.box("auth");
    box.put("username", "");
    box.put("password", "");
    box.put("is_loggined", false);
  }
}
