import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/util.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UsersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> updateList() {
      Functions.getUsersList();
      print("sth");
    }

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
      // ignore: missing_return
      body: FutureBuilder(
          future: Future.delayed(
            Duration(seconds: 1),
            () => Functions.getUsersList(),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (cnx, index) {
                    print(snapshot.data);
                    return UserBox(
                      username: snapshot.data[index]["username"],
                      name: snapshot.data[index]["name"],
                      family: snapshot.data[index]["family"],
                      phonenumber: snapshot.data[index]["phone"],
                      bluck: snapshot.data[index]["bluck"],
                      vahed: snapshot.data[index]["vahed"],
                      isAdmin: snapshot.data[index]["is_admin"],
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("مشکلی پیش آمد! " + snapshot.data.toString()),
                );
              }
            } else {
              return Center(
                child: SpinKitThreeBounce(
                  color: Hive.box("theme").get("is_dark")
                      ? Colors.amber
                      : Colors.blue,
                ),
              );
            }
          }),
    );
  }
}

class UserBox extends StatelessWidget {
  @override
  String username;
  String name;
  String family;
  String phonenumber;
  String bluck;
  String vahed;
  String isAdmin;
  UserBox(
      {this.username,
      this.name,
      this.family,
      this.phonenumber,
      this.bluck,
      this.vahed,
      this.isAdmin});
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopUP(
              target: username,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("نام کاربری: $username"),
                Text("نام و نام خانوادگی: $name $family"),
                Text("شمارهٔ تلفن: $phonenumber"),
                Text("بلوک: $bluck"),
                Text("واحد: $vahed"),
                Text("نوع کاربر: $isAdmin"),
              ],
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      ),
    );
  }
}

class PopUP extends StatelessWidget {
  @override
  String target;
  PopUP({this.target});
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (privilege) async {
        print(privilege);
        Get.defaultDialog(
            title: "هشدار!",
            middleText: "آیا مایلید دسترسی کاربر تغییر کند؟",
            textConfirm: "بله",
            textCancel: "خیر",
            onConfirm: () async {
              await Functions.changePrivilege(
                Hive.box("auth").get("username"),
                Hive.box("auth").get("password"),
                target,
                privilege,
              );
              Get.back();
              Get.snackbar("وضعیت", "با موفقیت دسترسی اعمال شد!");
            });
      },
      icon: Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (cnx) => [
        PopupMenuItem(
          value: 'no',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("تبدیل به کاربر عادی"),
              Icon(Icons.person),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'bluck1',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("تبدیل به مدیر بلوک۱"),
              Icon(Icons.add_moderator_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'bluck2',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("تبدیل به مدیر بلوک۲"),
              Icon(Icons.add_moderator_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'bluck3',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("تبدیل به مدیر بلوک۳"),
              Icon(Icons.add_moderator_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("پاک کردن کاربر"),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
