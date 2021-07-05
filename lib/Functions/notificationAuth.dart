import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> notificationAuth() async {
  Firebase.initializeApp().whenComplete(() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Yetkilendirildi');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Provisional Yetkilendirildi');
    } else {
      print('Yetkilendirilemedi');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Test');
    });

  });

}