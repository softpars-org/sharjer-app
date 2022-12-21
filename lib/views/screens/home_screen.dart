import 'package:flutter/material.dart';
import 'package:mojtama/models/navbar_model.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  PersistentTabController _controller = PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<NavBarModel, ThemeModel>(
        builder: (context, navModel, themeModel, child) {
      navModel.context = context;
      return PersistentTabView(
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
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style9, // Choose the nav bar style with this property.
      );
    });
  }
}
