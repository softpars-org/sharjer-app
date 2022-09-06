import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/pages/adminScreens/charge_status.dart';
import 'package:mojtama/utils/functionController.dart';
import 'package:mojtama/utils/util.dart';

class UsersListPage extends StatelessWidget {
  @override
  AdminAPI adminAPI = AdminAPI();
  Widget build(BuildContext context) {
    Future<void>? updateList() {
      // Functions.getUsersList();

      adminAPI.getUsersList();
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
          future: adminAPI.getUsersList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (cnx, index) {
                    return UserBox(
                      username: snapshot.data[index]["username"],
                      name: snapshot.data[index]["name"],
                      family: snapshot.data[index]["family"],
                      phonenumber: snapshot.data[index]["phone"],
                      bluck: snapshot.data[index]["bluck"],
                      vahed: snapshot.data[index]["vahed"],
                      isAdmin: snapshot.data[index]["is_admin"],
                      startDate: snapshot.data[index]["startdate"],
                      endDate: snapshot.data[index]["enddate"],
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
                child: SpinKitChasingDots(
                  size: 40,
                  color: Theme.of(context).accentColor,
                ),
              );
            }
          }),
    );
  }
}

class UserBox extends StatelessWidget {
  @override
  String? username;
  String? name;
  String? family;
  String? phonenumber;
  String? bluck;
  String? vahed;
  String? isAdmin;
  String? startDate;
  String? endDate;
  UserBox({
    this.username,
    this.name,
    this.family,
    this.phonenumber,
    this.bluck,
    this.vahed,
    this.isAdmin,
    this.startDate,
    this.endDate,
  });
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                  //this function change the isAdmin to
                  //a human readable text! e.i: bluck3 is changed to مدیر بلوک۳
                  Text("نوع کاربر: ${Functions.adminTypeChanger(isAdmin)}"),
                  Text("تاریخ ورود: $startDate"),
                  Text("تاریخ خروج: $endDate"),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        ),
      ),
    );
  }
}

class PopUP extends StatelessWidget {
  @override
  String? target;
  PopUP({this.target});
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (dynamic privilege) async {
        if (privilege == "charge_stats") {
          Navigator.push(
            context,
            GetPageRoute(
              page: () => StatusPageUser(
                username: target,
              ),
            ),
          );
        } else {
          Get.defaultDialog(
              title: "هشدار!",
              middleText: "آیا مایلید دسترسی کاربر تغییر کند؟",
              textConfirm: "بله",
              textCancel: "خیر",
              onConfirm: () async {
                var response = await Functions.changePrivilege(
                  Hive.box("auth").get("username"),
                  Hive.box("auth").get("password"),
                  target,
                  privilege,
                );
                Get.back();
                Get.snackbar(
                  "وضعیت",
                  response["status"],
                );
              });
        }
      },
      icon: Icon(Icons.more_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (cnx) => [
        PopupMenuItem(
          value: 'charge_stats',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("وضعیت شارژ کاربر"),
              Icon(Icons.assignment),
            ],
          ),
        ),
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
