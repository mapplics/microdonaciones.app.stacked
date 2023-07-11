import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.bottomsheets.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked_services/stacked_services.dart';

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

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await dotenv.load(fileName: fileNameEnv);
      await Firebase.initializeApp();
      logInfo('Firebase initialized!');
    } catch (e) {
      logError('Firebase initialized failed! ${e.toString()}');
    }

    // await FirebaseAuth.instance.signInAnonymously().then((value) {
    //   logInfo('Firebase Auth signedAnonymously!');
    // }).catchError((error) {
    //   logError('Firebase Auth signedAnonymously failed!');
    // });

    runApp(const MyApp());
  }, (error, stack) {
    logError('<main.dart> ${error.toString()}');
    logError('<main.dart> ${stack.toString()}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: CustomStylesTheme.lightGreyColor,
      useDefaultLoading: false,
      overlayOpacity: 0.5,
      overlayWidget: const Center(
        child: CircularProgressIndicator(
          color: CustomStylesTheme.primaryColor,
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CustomStylesTheme.mainTheme,
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
