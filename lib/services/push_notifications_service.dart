
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microdonations/core/constants/constant_data.dart';
import 'package:microdonations/main.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final _secureStorage = const FlutterSecureStorage();

  PushNotificationService(this._fcm);

  Future initialise() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await getToken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          showSimpleNotification(
            Text(message.notification!.title ?? ""),
            leading: Image.asset(
              "${ConstantData.assetsPath}ic_notification.png",
            ),
            subtitle: Text(message.notification!.body ?? ""),
            background: ConstantData.primaryColor,
            duration: const Duration(seconds: 2),
          );
        }
      });
    }

    // Lisitnening to the background messages
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  Future<void> getToken() async {
    FirebaseMessaging.instance.getToken().then((token) async {
      await _secureStorage.write(key: ConstantData.deviceToken, value: token);
    });
  }
}
