import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojtama/models/adminpanel_model.dart';
import 'package:mojtama/models/month_model.dart';
import 'package:mojtama/models/navbar_model.dart';
import 'package:mojtama/models/payment_model.dart';
import 'package:mojtama/models/permission_model.dart';
import 'package:mojtama/models/plak_model.dart';
import 'package:mojtama/models/scroll_model.dart';
import 'package:mojtama/models/state_model.dart';
import 'package:mojtama/models/theme_model.dart';
import 'package:mojtama/models/year_model.dart';
import 'package:mojtama/services/app_service.dart';
import 'package:mojtama/services/user_api_service.dart';
import 'package:mojtama/viewmodels/change_password_model.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.openBox("theme");
  await Hive.openBox("auth");
  UserProvider userProvider = UserProvider();
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    await userProvider.updateFirebaseToken(fcmToken);
  });

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

  var box = Hive.box("theme");
  box.put("isDarkTheme", box.get("isDarkTheme") ?? false);
  box.put("is_loggined", box.get("is_loggined") ?? false);
  var isDarkTheme = box.get("isDarkTheme");
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
        ChangeNotifierProvider(create: (_) => PermissionModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordModel())
      ],
      child: const MyApp(),
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
        navigatorKey: navigatorKey,
        title: 'مجتمع آملی',
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehaviour(),
        theme: model.currentTheme,
        initialRoute:
            Hive.box("auth").get("is_loggined") ?? false ? "/home" : "/login",
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
