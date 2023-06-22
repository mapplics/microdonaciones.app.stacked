import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:microdonations/app/app.bottomsheets.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/ui/common/logger.helpers.dart';
import 'package:stacked_services/stacked_services.dart';

import 'ui/common/app_theme.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp();
      logInfo('Firebase initialized!');
    } catch (e) {
      logError('Firebase initialized failed!');
    }

    // await FirebaseAuth.instance.signInAnonymously().then((value) {
    //   logInfo('Firebase Auth signedAnonymously!');
    // }).catchError((error) {
    //   logError('Firebase Auth signedAnonymously failed!');
    // });

    runApp(const MyApp());
  }, (error, stack) {
    logError('<main.dart> ${error.toString()}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomStylesTheme.mainTheme,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
