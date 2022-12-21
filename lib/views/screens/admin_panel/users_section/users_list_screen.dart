import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("لیست اعضا"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "بلوک۱",
              ),
              Tab(
                text: "بلوک۲",
              ),
              Tab(
                text: "بلوک۳",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (context, index) => UserCard(),
            ),
            ListView.builder(
              itemBuilder: (context, index) => UserCard(),
            ),
            ListView.builder(
              itemBuilder: (context, index) => UserCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThreeDots(),
              Text("نام کاربری: username"),
              Text("نام و نام خانوادگی: namefamily"),
              Text("بلوک: ۱"),
              Text("واحد: ۱۳"),
              SelectableText("شمارهٔ تلفن: phonenumber"),
              Text("پلاک خودرو: plak khodro"),
            ],
          ),
        ),
      ),
    );
  }
}

class ThreeDots extends StatelessWidget {
  const ThreeDots({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List> popupItems = {
      "strings": [
        "وضعیت شارژ کاربر",
        "تبدیل به مدیر بلوک۱",
        "تبدیل به مدیر بلوک۲",
        "تبدیل به مدیر بلوک۳",
        "حذف کاربر",
      ],
      "icons": [
        Icons.assignment,
        Icons.admin_panel_settings,
        Icons.admin_panel_settings,
        Icons.admin_panel_settings,
        Icons.delete,
      ],
    };
    return InkWell(
      onTap: () {
        AppService appService = AppService(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor.withOpacity(0.4),
        ),
        child: PopupMenuButton(
          splashRadius: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tooltip: "تنظیمات کاربر",
          onSelected: (value) {},
          itemBuilder: (context) {
            List<PopupMenuItem> popItems = [];
            for (int i = 0; i < popupItems["strings"]!.length; i++) {
              popItems.add(
                PopupMenuItem(
                  value: popupItems["strings"]![i],
                  child: Row(
                    children: [
                      Icon(
                        popupItems["icons"]![i],
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text(popupItems["strings"]![i]),
                    ],
                  ),
                ),
              );
            }
            return popItems;
          },
        ),
      ),
    );
  }
}
