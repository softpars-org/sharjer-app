import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseSettings {
  final firebase = FirebaseMessaging.instance;
  var fcmToken;
  var settings;
  FirebaseSettings() {
    fcmToken = firebase.getToken();
  }

  Future<String?> get token {
    return firebase.getToken();
  }

  notificationSettings() async {
    settings = await firebase.requestPermission(
        alert: true, sound: true, announcement: true);
    print('User granted permission: ${settings.authorizationStatus}');
  }

  onTokenUpdate() {
    firebase.onTokenRefresh.listen((token) => print("updated token: $token"));
  }

  onMessageArrived() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("A data has arrived!");
      print("The message: ${message.data}");
    });
  }
}
