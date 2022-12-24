import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/models/adminpanel_model.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/navbar_model.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/models/scroll_model.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  await Hive.openBox("auth");
  var box = Hive.box("theme");
  box.put("isDarkTheme", box.get("isDarkTheme") ?? false);
  box.put("isLoggined", box.get("isLoggined") ?? false);
  var isDarkTheme = box.get("isDarkTheme");
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          isDarkTheme ? Color(0xff282a36) : Color(0xffece5dd),
      systemNavigationBarIconBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: isDarkTheme ? Color(0xff282a36) : Color(0xff075e54),
      statusBarBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NavBarModel()),
        ChangeNotifierProvider(create: (_) => CheckboxModel()),
        ChangeNotifierProvider(create: (_) => PaymentModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => YearModel()),
        ChangeNotifierProvider(create: (_) => MonthsModel()),
        ChangeNotifierProvider(create: (_) => RadioMonthModel()),
        ChangeNotifierProvider(create: (_) => AdminPanelModel()),
        ChangeNotifierProvider(create: (_) => MojtamaStatusExpansionModel()),
      ],
      child: MyApp(),
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.black,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, model, child) {
      return MaterialApp(
        title: 'مجتمع آملی',
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehaviour(),
        theme: model.currentTheme,
        initialRoute: "/login",
        routes: {
          "/home": (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: HomeScreen(),
              ),
          "/login": (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: LoginPage(),
              ),
        },
      );
    });
  }
}
