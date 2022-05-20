import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/Admin/change_month.dart';
import 'package:mojtama/pages/Admin/change_sharge.dart';
import 'package:mojtama/pages/Admin/privilage.dart';
import 'package:mojtama/pages/Admin/users_list.dart';
import 'package:mojtama/pages/settings.dart';

class AdminOptions extends StatelessWidget {
  @override
  var box = Hive.box("theme");
  var admin_mode = Hive.box("auth").get("is_admin");

  Widget build(BuildContext context) {
    int getadminstat() {
      if (admin_mode == "full") {
        return 100;
      } else if (admin_mode == "bluck1") {
        return 1;
      } else if (admin_mode == "bluck2") {
        return 2;
      } else if (admin_mode == "bluck3") {
        return 3;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مدیریت",
          style: Theme.of(context).primaryTextTheme.headline6,
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
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          getadminstat() == 100
              ? Choice(
                  icon: Icon(Icons.group),
                  text: "لیست اعضا",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsersListPage()));
                  },
                )
              : Choice(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsersListPage()));
                  },
                  text: "لیست اعضای بلوک " + getadminstat().toString(),
                  icon: Icon(Icons.group),
                ),

          getadminstat() == 100
              ? Choice(
                  icon: Icon(Icons.change_circle),
                  text: "تغییر میزان شارژ",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeShargePrice()));
                  })
              : Container(),
          getadminstat() == 100
              ? Choice(
                  icon: Icon(Icons.redo),
                  text: "تغییر ماه شارژ",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChangeMonth()));
                  })
              : Container(),
          //Choice(),
        ],
      ),
    );
  }
}

class Choice extends StatelessWidget {
  @override
  String text;
  Icon icon;
  Function() onPressed;
  Choice({this.text, this.icon, @required this.onPressed});

  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 1, 30, 3),
        child: Column(
          children: [
            ListTile(
              title: Text(
                text,
                style: TextStyle(fontSize: 14, color: Get.theme.accentColor),
              ),
              leading: icon,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: onPressed == null ? () {} : onPressed,
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
