import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mojtama/utils/bottomNavController.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mojtama/utils/themeModel.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PersistentView extends StatelessWidget {
  PersistentView({Key? key}) : super(key: key);
  BottomNavController controller = Get.put(BottomNavController());
  PersistentTabController _controller = PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (_) {
        return PersistentTabView(
          context,
          screens: controller.widgets,
          controller: _controller,
          items: controller.items,
          confineInSafeArea: true,
          backgroundColor: _.isDark
              ? Colors.black
              : Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            colorBehindNavBar: Colors.white,
          ),
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
            curve: Curves.easeInOutBack,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style9,
        );
      },
    );
  }
}
