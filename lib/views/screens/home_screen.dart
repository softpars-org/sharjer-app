import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/viewmodels/navbar_model.dart';
import 'package:mojtama/viewmodels/permission_model.dart';
import 'package:mojtama/viewmodels/theme_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller = PersistentTabController();
  bool canPop = false;
  bool isFirstPop = true;
  DateTime? popTime;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        UserProvider userProvider = UserProvider(
          snackbarService: SnackbarService(context),
        );
        await userProvider.updateFirebaseToken(fcmToken);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AppService(context).throwDialog(
          message.notification!.body!,
        );
      }); //it should be fixed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NavBarModel, ThemeModel>(
        builder: (context, navModel, themeModel, child) {
      navModel.context = context;
      return ChangeNotifierProvider<PermissionModel>(
          create: (_) => PermissionModel(
                userProvider: UserProvider(
                  snackbarService: SnackbarService(context),
                ),
              ),
          builder: (context, provider) {
            return PopScope(
              canPop: canPop,
              onPopInvoked: (popped) {
                setState(() {
                  if (isFirstPop) {
                    isFirstPop = false;
                    popTime = DateTime.now();
                    SnackbarService(context).showSnackbar(
                        message: "برای خارج شدن از برنامه، دوباره ضربه بزنید");
                  } else {
                    if (DateTime.now().difference(popTime!).inSeconds < 2) {
                      SystemNavigator.pop();
                    } else {
                      isFirstPop = true;
                      SnackbarService(context).showSnackbar(
                          message:
                              "برای خارج شدن از برنامه، دوباره ضربه بزنید");
                    }
                  }
                });
              },
              child: PersistentTabView(
                context,
                controller: _controller,
                screens: navModel.screens,
                items: navModel.items,
                confineInSafeArea: true,
                backgroundColor: Theme.of(context)
                    .scaffoldBackgroundColor, // Default is Colors.white.
                handleAndroidBackButtonPress: true, // Default is true.

                resizeToAvoidBottomInset:
                    true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows:
                    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: false,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle
                    .style9, // Choose the nav bar style with this property.
              ),
            );
          });
    });
  }
}
