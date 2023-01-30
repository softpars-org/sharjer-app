import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/models/adminpanel_model.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/add_charge_to_user_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/remove_charge_from_user_screen.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<AdminPanelModel>(context, listen: false);
    List<User> users = await provider.getUsers();
    users.sort((a, b) => a.bluck.compareTo(1));
    users.sort((a, b) => a.bluck.compareTo(2));
    users.sort((a, b) => a.bluck.compareTo(3));
    provider.filterUsersByBluck();
  }

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
        body: Consumer<AdminPanelModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: model.getUsersLengthOfBluck(1),
                        itemBuilder: (context, index) => UserCard(
                          user: model.bluck1Users[index],
                        ),
                      ),
                      ListView.builder(
                        itemCount: model.getUsersLengthOfBluck(2),
                        itemBuilder: (context, index) => UserCard(
                          user: model.bluck2Users[index],
                        ),
                      ),
                      ListView.builder(
                        itemCount: model.getUsersLengthOfBluck(3),
                        itemBuilder: (context, index) => UserCard(
                          user: model.bluck3Users[index],
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  User user;
  UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        expandedAlignment: Alignment.topRight,
        childrenPadding: EdgeInsets.all(30),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text("${user.name} ${user.family}"),
        subtitle: Text("بلوک ${user.bluck}، واحد ${user.vahed}"),
        children: [
          // Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [],
          //     ),
          //   ),
          // ),
          ThreeDots(
            username: user.username,
          ),
          Text("نام کاربری: ${user.username}"),
          Text("نام و نام خانوادگی: ${user.family}"),
          Text("بلوک: ${user.bluck}"),
          Text("واحد: ${user.vahed}"),
          SelectableText("شمارهٔ همراه: ${user.phone}"),
          SelectableText("شمارهٔ همراه۲: ${user.phone2}"),
          Text("پلاک خودرو: ${user.carPlate}"),
        ],
      ),
    );

    // return Container(
    //   padding: EdgeInsets.all(20),
    //   child:
    // );
  }
}

class ThreeDots extends StatelessWidget {
  String username;
  ThreeDots({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppService appService = AppService(context);

    Map<String, List> popupItems = {
      "strings": [
        "وضعیت شارژ",
        "اضافه کردن شارژ",
        "حذف شارژ",
        "تبدیل به مدیر بلوک۱",
        "تبدیل به مدیر بلوک۲",
        "تبدیل به مدیر بلوک۳",
        "حذف کاربر",
      ],
      "icons": [
        Icons.assignment,
        Icons.add_card,
        Icons.credit_card_off,
        Icons.admin_panel_settings,
        Icons.admin_panel_settings,
        Icons.admin_panel_settings,
        Icons.delete,
      ],
    };
    return InkWell(
      onTap: () {},
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
          onSelected: (value) {
            if (value == "اضافه کردن شارژ") {
              appService.navigate(AddChargeToUserScreen(
                username: username,
              ));
            } else if (value == "حذف شارژ") {
              appService.navigate(RemoveChargeFromUserScreen(
                username: username,
              ));
            }
          },
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
