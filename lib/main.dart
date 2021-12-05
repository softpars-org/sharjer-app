import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mojtama/pages/dashboard.dart';
import 'package:mojtama/pages/settings.dart';
import 'package:mojtama/pages/statusPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'pages/login.dart';
import 'pages/payment.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/util.dart';
import 'package:get/get.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  await Hive.openBox("auth");

  // print('User granted permission: ${settings.authorizationStatus}');
  if (Hive.box("auth").get("is_loggined") == null) {
    Hive.box("auth").put("is_loggined", false);
  }
  runApp(MyApp());
}

Rx<MaterialColor> activeColorPrimaryDark = Colors.yellow.obs;
Rx<MaterialColor> inactiveColorPrimaryDark = Colors.grey.obs;
Rx<MaterialColor> activeColorPrimaryLight = Colors.blue.obs;
Rx<MaterialColor> inactiveColorPrimaryLight = Colors.grey.obs;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<Widget> items = [
  Directionality(
    textDirection: TextDirection.rtl,
    child: Hive.box("auth").get("is_loggined") ? LogginedPage() : LoginPage(),
  ),
  Directionality(
    textDirection: TextDirection.rtl,
    child: PaymentPage(),
  ),
  Directionality(
    textDirection: TextDirection.rtl,
    child: StatusPageUser(),
  ),
  Directionality(
    textDirection: TextDirection.rtl,
    child: SettingsPage(),
  ),
];

class ThemeService {
  var box = Hive.box("theme");
  ThemeMode get theme => box.get("is_dark") ? ThemeMode.dark : ThemeMode.light;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("theme");
    if (box.get("is_dark") == null) {
      box.put("is_dark", false);
    }

    if (Hive.box("auth").get("is_loggined") == null) {
      Hive.box("auth").put("is_loggined", false);
    }
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('fa'),
      initialRoute: Hive.box("auth").get("is_loggined") ? "/home" : "/login",
      getPages: [
        GetPage(
          name: "/home",
          page: () {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: TabView(),
            );
          },
        ),
        GetPage(
          name: "/login",
          page: () {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: LoginPage(),
            );
          },
        )
      ],
      debugShowCheckedModeBanner: false,
      title: "مجتمع آملی",
      theme: ThemeX.lightTheme,
      darkTheme: ThemeX.darkTheme,
      themeMode: ThemeService().theme,
    );
  }
}

var box = Hive.box("theme");
var _selectedIndex = 0.obs;

class MainWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void changeIndex(int index) {
      print(index);
      _selectedIndex.value = index;
    }

    return Scaffold(
      bottomNavigationBar: Obx(() => PersistentBottomNavBar()),
    );
  }
}

class TabView extends StatelessWidget {
  @override
  var box = Hive.box("theme");

  Widget build(BuildContext context) {
    PersistentTabController tabController = PersistentTabController(
      initialIndex: _selectedIndex.value == null ? 0 : _selectedIndex.value,
    );

    _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          // icon: Icon(Icons.perm_identity),
          icon: Icon(
            Icons.dashboard,
            size: 30,
          ),
          title: ("پیش‌خوان"),
          activeColorPrimary: box.get("is_dark")
              ? activeColorPrimaryDark.value
              : activeColorPrimaryLight.value,
          inactiveColorPrimary: box.get("is_dark")
              ? inactiveColorPrimaryDark.value
              : inactiveColorPrimaryLight.value,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.payment,
            size: 30,
          ),
          title: ("پرداخت شارژ"),
          activeColorPrimary: box.get("is_dark")
              ? activeColorPrimaryDark.value
              : activeColorPrimaryLight.value,
          inactiveColorPrimary: box.get("is_dark")
              ? inactiveColorPrimaryDark.value
              : inactiveColorPrimaryLight.value,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.assignment,
            size: 30,
          ),
          title: ("وضعیت شارژ"),
          activeColorPrimary: box.get("is_dark")
              ? activeColorPrimaryDark.value
              : activeColorPrimaryLight.value,
          inactiveColorPrimary: box.get("is_dark")
              ? inactiveColorPrimaryDark.value
              : inactiveColorPrimaryLight.value,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
          title: ("تنظیمات"),
          activeColorPrimary: box.get("is_dark")
              ? activeColorPrimaryDark.value
              : activeColorPrimaryLight.value,
          inactiveColorPrimary: box.get("is_dark")
              ? inactiveColorPrimaryDark.value
              : inactiveColorPrimaryLight.value,
        ),
      ];
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PersistentTabView(
        context,
        controller: tabController,
        screens: items,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: box.get("is_dark")
            ? Colors.black
            : Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
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
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 70),
        ),
        navBarStyle:
            NavBarStyle.style9, // Choose the nav bar style with this property.
        //
      ),
    );
  }
}
