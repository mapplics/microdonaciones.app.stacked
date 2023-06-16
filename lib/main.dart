import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:microdonations/app/app.bottomsheets.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import 'ui/common/app_theme.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await FirebaseAuth.instance.signInAnonymously().then((value) {
      print('signedAnonymously');
    }).catchError((error) {
      print('<Print> FirebaseAuth.instance ERROR');
    });

    print('listo');
    runApp(const MyApp());
  }, (error, stack) {
    print('Error custom $error');
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
