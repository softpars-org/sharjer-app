import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mojtama/pages/adminScreens/admin_panel.dart';
import 'package:mojtama/pages/adminScreens/privilage.dart';

import 'package:mojtama/widgets/bottomNavigationBar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'pages/login.dart';
import 'utils/theme.dart';
import 'package:get/get.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  await Hive.openBox("auth");

  //final fcmToken = await FirebaseMessaging.instance.getToken();
  if (Hive.box("auth").get("is_loggined") == null) {
    Hive.box("auth").put("is_loggined", false);
  }
  runApp(MyApp());
}

class ThemeService {
  var box = Hive.box("theme");
  ThemeMode get theme => box.get("is_dark") ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("theme");
    box.get("is_dark") ?? box.put("is_dark", false);
    Hive.box("auth").get("is_loggined") ??
        Hive.box("auth").put("is_loggined", false);
    return GetMaterialApp(
      defaultTransition: Transition.topLevel,
      textDirection: TextDirection.rtl,
      locale: Locale('fa'),
      initialRoute: Hive.box("auth").get("is_loggined") ? "/home" : "/login",
      getPages: [
        GetPage(
          name: "/home",
          page: () => PersistentView(),
        ),
        GetPage(name: "/adminoptions", page: () => AdminOptions()),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      title: "مجتمع آملی",
      theme: ThemeX.lightTheme,
      darkTheme: ThemeX.darkTheme,
      themeMode: ThemeService().theme,
    );
  }
}
