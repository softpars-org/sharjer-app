import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData? currentTheme;
  final box = Hive.box("theme");
  ThemeModel() {
    currentTheme = box.get("isDarkTheme") ? darkTheme : lightTheme;
  }

  ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xff075e54),
    fontFamily: "VazirLight",
    colorScheme: ColorScheme.light(
      primary: Color(0xff075e54),
      secondary: Color(0xff075e54),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 1.0,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w100,
        color: Colors.white,
        fontFamily: "VazirLight",
        fontSize: 20,
      ),
      backgroundColor: Color(0xff075e54),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        Color(0xff075e54),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Color(0xff075e54),
      ),
    ),
    backgroundColor: Color(0xffece5dd),
    iconTheme: IconThemeData(color: Colors.white),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
  );

  ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xffbd93f9),
    fontFamily: "VazirLight",
    colorScheme: ColorScheme.dark(
      primary: Color(0xffbd93f9),
      secondary: Color(0xffff79c6),
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Color(0xffbd93f9),
      titleTextStyle: TextStyle(
        color: Color(0xffbd93f9),
        fontFamily: "VazirLight",
        fontSize: 20,
      ),
      backgroundColor: Color(0xff282a36),
      elevation: 1.0,
      centerTitle: true,
    ),
    cardColor: Color(0xff44475a),
    scaffoldBackgroundColor: Color(0xff282a36),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Color(0xffbd93f9)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Color(0xffbd93f9),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xffbd93f9),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Color(0xffbd93f9),
    ),
  );

  bool get isDarkMode {
    return currentTheme == darkTheme;
  }

  toggleTheme() {
    if (isDarkMode) {
      box.put("isDarkTheme", !isDarkMode);
      currentTheme = lightTheme;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffece5dd),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: lightTheme.primaryColor,
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      box.put("isDarkTheme", !isDarkMode);
      currentTheme = darkTheme;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: darkTheme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: darkTheme.scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
      ));
    }
    notifyListeners();
  }
}
