import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/services/app_services/snackbar_service.dart';
import 'package:mojtama/viewmodels/adminpanel_model.dart';
import 'package:mojtama/viewmodels/month_model.dart';
import 'package:mojtama/viewmodels/navbar_model.dart';
import 'package:mojtama/viewmodels/network_viewmodel.dart';
import 'package:mojtama/viewmodels/payment_model.dart';
import 'package:mojtama/viewmodels/plak_model.dart';
import 'package:mojtama/models/scroll_model.dart';
import 'package:mojtama/viewmodels/state_model.dart';
import 'package:mojtama/viewmodels/theme_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/viewmodels/change_password_model.dart';
import 'package:mojtama/viewmodels/who_didnt_pay_model.dart';
import 'package:mojtama/views/screens/auth_screens/login_screen.dart';
import 'package:mojtama/views/screens/home_screen.dart';
import 'package:mojtama/views/screens/payment_history_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await Hive.openBox("theme");
  await Hive.openBox("auth");
  if (Platform.isAndroid || Platform.isIOS) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["navigation"] == "/history_screen") {
        Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => PaymentHistoryScreen(),
          ),
        );
      }
    });
  }

  var box = Hive.box("theme");
  box.put("is_dark_mode", box.get("is_dark_mode") ?? false);
  box.put("is_loggined", box.get("is_loggined") ?? false);
  bool isDarkTheme = box.get("is_dark_mode") ?? false;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          isDarkTheme ? const Color(0xff282a36) : Colors.white,
      systemNavigationBarIconBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark,
      statusBarColor:
          isDarkTheme ? const Color(0xff282a36) : const Color(0xff075e54),
      statusBarBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NavBarModel()),
        ChangeNotifierProvider(create: (_) => PlakModel()),
        ChangeNotifierProvider(create: (_) => CheckboxModel()),
        ChangeNotifierProvider(create: (_) => PaymentModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => YearModel()),
        ChangeNotifierProvider(create: (_) => MonthsModel()),
        ChangeNotifierProvider(create: (_) => RadioMonthModel()),
        ChangeNotifierProvider(create: (_) => AdminPanelModel()),
        ChangeNotifierProvider(create: (_) => MojtamaStatusExpansionModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordModel()),
        ChangeNotifierProvider(create: (_) => WhoDidntPayChargeModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, model, child) {
      final isLoggined = Hive.box("auth").get("is_loggined") ?? false;
      return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'مجتمع آملی',
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehaviour(),
        theme: model.currentTheme,
        home: ChangeNotifierProvider(
          create: (_) => NetworkViewModel(snackbarService: SnackbarService(_)),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: isLoggined ? HomeScreen() : LoginPage(),
            );
          },
        ),
      );
    });
  }
}
