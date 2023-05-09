import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/models/adminpanel_model.dart';
import 'package:mojtama/models/permission_model.dart';
import 'package:mojtama/models/user_model.dart';
import 'package:mojtama/services/admin_api_service.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/encryption_service.dart';
import 'package:mojtama/views/screens/admin_panel/user_charge_status/user_charge_status_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/add_charge_to_user_screen.dart';
import 'package:mojtama/views/screens/admin_panel/users_section/remove_charge_from_user_screen.dart';
import 'package:mojtama/views/widgets/car_plate_shower_widget.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider = Provider.of<AdminPanelModel>(context, listen: false);
    List<User> users = await provider.getUsers();
    provider.filterUsersByBluck();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("لیست اعضا"),
          bottom: const TabBar(
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
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () => _loadResources(),
                        child: ListView.builder(
                          itemCount: model.getUsersLengthOfBluck(1),
                          itemBuilder: (context, index) => UserCard(
                            user: model.bluck1Users[index],
                          ),
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

  String _generateHumanizedPermission(String userType) {
    switch (userType) {
      case "no":
        return "عادی";
      case "bluck1":
        return "مدیر بلوک۱";
      case "bluck2":
        return "مدیر بلوک۲";
      case "bluck3":
        return "مدیر بلوک۳";
      case "full":
        return "مدیر مجتمع";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        expandedAlignment: Alignment.topRight,
        childrenPadding: const EdgeInsets.all(30),
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
            user: user,
          ),
          Text("نام کاربری: ${user.username}"),
          Text("نام و نام خانوادگی: ${user.name} ${user.family}"),
          Text("بلوک: ${user.bluck}"),
          Text("واحد: ${user.vahed}"),
          Text("نوع کاربر: ${_generateHumanizedPermission(user.userType)}"),
          SelectableText("شمارهٔ همراه: ${user.phone}"),
          SelectableText("شمارهٔ همراه۲: ${user.phone2}"),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CarPlateShower(
                  carPlate: user.carPlate,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              )
            ],
          )
        ],
      ),
    );

    // return Container(
    //   padding: EdgeInsets.all(20),
    //   child:
    // );
  }
}

class ThreeDots extends StatefulWidget {
  User user;
  ThreeDots({Key? key, required this.user}) : super(key: key);

  @override
  State<ThreeDots> createState() => _ThreeDotsState();
}

class _ThreeDotsState extends State<ThreeDots> {
  Map<String, dynamic> popupItems = {
    "strings": [
      "وضعیت شارژ",
      "اضافه کردن شارژ",
      "حذف شارژ",
      "مشاهده گذرواژه کاربر",
      "تبدیل به کاربر عادی",
      "تبدیل به مدیر بلوک۱",
      "تبدیل به مدیر بلوک۲",
      "تبدیل به مدیر بلوک۳",
      "حذف کاربر",
    ],
    "icons": [
      Icons.assignment_outlined,
      Icons.add_card_outlined,
      Icons.credit_card_off_outlined,
      Icons.visibility_rounded,
      Icons.person_outlined,
      Icons.admin_panel_settings_outlined,
      Icons.admin_panel_settings_outlined,
      Icons.admin_panel_settings_outlined,
      Icons.delete_outline,
    ],
  };
  late AdminPanelModel model;
  @override
  void initState() {
    super.initState();
    model = Provider.of(context, listen: false);
  }

  Future<void> _handlePopupMenu(choice) async {
    AppService appService = AppService(context);
    List<dynamic> choices = popupItems["strings"];
    switch (choice) {
      case "وضعیت شارژ":
        appService.navigate(UserChargeStatusScreen(user: widget.user));
        break;
      case "اضافه کردن شارژ":
        appService
            .navigate(AddChargeToUserScreen(username: widget.user.username));
        break;
      case "حذف شارژ":
        appService.navigate(
            RemoveChargeFromUserScreen(username: widget.user.username));
        break;
      case "مشاهده گذرواژه کاربر":
        var permissionProvider =
            Provider.of<PermissionModel>(context, listen: false);
        bool isFullAdmin = (permissionProvider.userPermissionType == "full");
        if (!isFullAdmin) {
          appService.snackBar("شما دسترسی این کار را ندارید.");
          break;
        }
        String decryptedPassword =
            await Encryption().decrypt(widget.user.password);
        // ignore: use_build_context_synchronously
        appService.throwDialog(
          context,
          decryptedPassword,
          okMsg: "کپی",
          errMsg: "بازگشت",
          handleSuccess: () {
            Clipboard.setData(ClipboardData(
              text: decryptedPassword,
            ));
          },
          handleError: () {},
        );
        break;
      case "تبدیل به کاربر عادی":
        AdminProvider adminProvider = AdminProvider();
        appService.throwDialog(
          context,
          "آیا با تبدیل کاربر به کاربر عادی موافقید؟",
          okMsg: "بله",
          errMsg: "خیر",
          handleSuccess: () async {
            String permissionType = "no"; //means no permission
            var response = await adminProvider.changeUserPrivilege(
              widget.user.username,
              permissionType,
            );
            switch (response) {
              case true:
                appService.snackBar("دسترسی با موفقیت تغییر کرد.");
                model.updateUserType(widget.user, permissionType);
                break;
              case false:
                appService.snackBar("مشکلی پیش آمد.");
                break;
              case -1:
                appService.snackBar("شما دسترسی اینکار را ندارید.");
                break;
            }
          },
          handleError: () {},
        );
        break;
      case "تبدیل به مدیر بلوک۱":
        AdminProvider adminProvider = AdminProvider();
        appService.throwDialog(
          context,
          "آیا با تبدیل کاربر به مدیر بلوک۱ موافقید؟",
          okMsg: "بله",
          errMsg: "خیر",
          handleSuccess: () async {
            String permissionType = "bluck1";
            var response = await adminProvider.changeUserPrivilege(
              widget.user.username,
              permissionType,
            );
            switch (response) {
              case true:
                appService.snackBar("دسترسی با موفقیت تغییر کرد.");
                model.updateUserType(widget.user, permissionType);
                break;
              case -1:
                appService.snackBar("شما دسترسی این کار را ندارید.");
                break;
              case false:
                appService.snackBar("مشکلی پیش آمد.");
                break;
            }
          },
          handleError: () {},
        );
        break;
      case "تبدیل به مدیر بلوک۲":
        AdminProvider adminProvider = AdminProvider();
        appService.throwDialog(
          context,
          "آیا با تبدیل کاربر به مدیر بلوک۲ موافقید؟",
          okMsg: "بله",
          errMsg: "خیر",
          handleSuccess: () async {
            String permissionType = "bluck2";
            var response = await adminProvider.changeUserPrivilege(
              widget.user.username,
              permissionType,
            );
            switch (response) {
              case true:
                appService.snackBar("دسترسی با موفقیت تغییر کرد.");
                model.updateUserType(widget.user, permissionType);
                break;
              case -1:
                appService.snackBar("شما دسترسی این کار را ندارید.");
                break;
              case false:
                appService.snackBar("مشکلی پیش آمد.");
                break;
            }
          },
          handleError: () {},
        );
        break;
      case "تبدیل به مدیر بلوک۳":
        AdminProvider adminProvider = AdminProvider();
        appService.throwDialog(
          context,
          "آیا با تبدیل کاربر به مدیر بلوک۳ موافقید؟",
          okMsg: "بله",
          errMsg: "خیر",
          handleSuccess: () async {
            String permissionType = "bluck3";
            var response = await adminProvider.changeUserPrivilege(
              widget.user.username,
              permissionType,
            );
            switch (response) {
              case true:
                appService.snackBar("دسترسی با موفقیت تغییر کرد.");
                model.updateUserType(widget.user, permissionType);
                break;
              case -1:
                appService.snackBar("شما دسترسی این کار را ندارید.");
                break;
              case false:
                appService.snackBar("مشکلی پیش آمد.");
                break;
            }
          },
          handleError: () {},
        );
        break;
      case "حذف کاربر":
        AdminProvider adminProvider = AdminProvider();
        appService.throwDialog(
          context,
          "آیا با حذف کاربر موافقید؟",
          okMsg: "بله",
          errMsg: "خیر",
          handleSuccess: () async {
            String permissionType = "delete";
            var response = await adminProvider.changeUserPrivilege(
              widget.user.username,
              permissionType,
            );
            switch (response) {
              case true:
                appService.snackBar("کاربر حذف شد.");
                model.updateUserType(widget.user, permissionType);
                break;
              case -1:
                appService.snackBar("شما دسترسی این کار را ندارید.");
                break;
              case false:
                appService.snackBar("مشکلی پیش آمد.");
                break;
            }
          },
          handleError: () {},
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onSelected: _handlePopupMenu,
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
                      const SizedBox(width: 10),
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
