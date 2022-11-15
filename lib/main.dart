import 'package:firebase_core/firebase_core.dart';
import 'package:mojtama/utils/firebase_settings.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mojtama/pages/adminScreens/admin_panel.dart';

import 'package:mojtama/widgets/bottomNavigationBar.dart';
import 'pages/login.dart';
import 'utils/theme.dart';
import 'package:get/get.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  await Hive.openBox("auth");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseSettings firebaseSettings = FirebaseSettings();
  firebaseSettings.notificationSettings();
  firebaseSettings.onTokenUpdate();
  firebaseSettings.onMessageArrived();

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
