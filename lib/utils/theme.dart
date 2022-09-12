import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeX {
  static bool is_dark = false;
  ThemeData ss = new ThemeData();

  static final lightTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
    primaryColor: Colors.blue,
    primaryColorDark: Color(0xFFFEA82F),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,

        // statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.blue),
      titleTextStyle:
          TextStyle(color: Colors.blue, fontFamily: 'Vazir', fontSize: 18),
    ),
    accentIconTheme: IconThemeData(
      color: Colors.blue,
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
    ),
    fontFamily: 'Vazir',
    buttonColor: Colors.blue,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.amber),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    ),
    brightness: Brightness.light,
    canvasColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.amber[800],
    primarySwatch: Colors.amber,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        // systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      elevation: 5.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.amber,
        fontFamily: 'Vazir',
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: Colors.amber),
    ),
    accentIconTheme: IconThemeData(
      color: Colors.amber,
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.amber, fontWeight: FontWeight.w300),
    ),
    primaryColorDark: Colors.black,
    fontFamily: 'Vazir',
    accentTextTheme: TextTheme(bodyText1: TextStyle(fontSize: 14)),
    buttonColor: Colors.amber[800],
    dividerColor: Colors.grey.shade800,
    textTheme: TextTheme(button: TextStyle(fontSize: 14)),
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    accentColor: Colors.amber,
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.amber)),
    shadowColor: Colors.grey,
    hoverColor: Colors.grey[800]!.withOpacity(0.6),
  );
}
