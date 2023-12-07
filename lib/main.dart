import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:microdonations/app/app.bottomsheets.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/firebase_options.dart';
import 'package:microdonations/services/push_notifications_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ui/common/app_theme.dart';

// controlo el archivo env que voy a cargar
get fileNameEnv {
  String env = const String.fromEnvironment("env");
  String fileNameEnv = "envs/.env";
  if (env.isNotEmpty && env == 'prod') {
    fileNameEnv = "envs/.env.prod";
  }

  return fileNameEnv;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
String? selectedNotificationPayload;

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    try {
      await dotenv.load(fileName: fileNameEnv);
      await Firebase.initializeApp();
      logInfo('Firebase initialized!');
    } catch (e) {
      logError('Firebase initialized failed! ${e.toString()}');
    }

    ////////////Notification Section///////////////
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

  //Permisions
  if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>() != null) {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
    //}
  }
  if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>() != null) {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()!.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    //}
  }
  //

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse? notification) async {
    },
  );

  ///////////////////////////

    runApp(const MyApp());
  }, (error, stack) {
    logError('<main.dart> ${error.toString()}');
    logError('<main.dart> ${stack.toString()}');
  });
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    final pushNotificationsService = PushNotificationService(_firebaseMessaging);
    pushNotificationsService.initialise();

    return GlobalLoaderOverlay(
      overlayColor: AppTheme.lightGreyColor,
      useDefaultLoading: false,
      overlayOpacity: 0.5,
      overlayWidget: const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      ),
      child: MaterialApp(
        title: 'MicroDonaciones',
        debugShowCheckedModeBanner: false,
        locale: const Locale(
          'es',
        ),
        supportedLocales: const [
          Locale('es'),
        ],
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.mainTheme,
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
      ),
    );
  }
}
