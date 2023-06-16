import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomStylesTheme {
  /// Colors
  ///
  ///
  static MaterialColor primaryColor = MaterialColor(
    kcPrimaryColor.value, // primary
    <int, Color>{
      50: Color(kcPrimaryColor.value),
      100: Color(kcPrimaryColor.value),
      200: Color(kcPrimaryColor.value),
      300: Color(kcPrimaryColor.value),
      400: Color(kcPrimaryColor.value),
      500: Color(kcPrimaryColor.value),
      600: Color(kcPrimaryColor.value),
      700: Color(kcPrimaryColor.value),
      800: Color(kcPrimaryColor.value),
      900: Color(kcPrimaryColor.value),
    },
  );

  static const secondaryColor = kcSecondaryColor;
  static const tertiaryColor = kcTertiaryColor;

  /// Theme
  ///
  ///
  static ThemeData mainTheme = ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    // canvasColor: Colors.transparent,
    // primarySwatch: CustomStylesTheme.primaryColor,

    // This is the theme of your application.
    //
    // TRY THIS: Try running your application with "flutter run". You'll see
    // the application has a blue toolbar. Then, without quitting the app,
    // try changing the seedColor in the colorScheme below to Colors.green
    // and then invoke "hot reload" (save your changes or press the "hot
    // reload" button in a Flutter-supported IDE, or press "r" if you used
    // the command line to start the app).
    //
    // Notice that the counter didn't reset back to zero; the application
    // state is not lost during the reload. To reset the state, use hot
    // restart instead.
    //
    // This works for code too, not just values: Most code changes can be
    // tested with just a hot reload.
    colorScheme: ColorScheme.fromSeed(
      //brightness: Brightness.dark,
      seedColor: CustomStylesTheme.primaryColor,
      primary: CustomStylesTheme.primaryColor,
      secondary: CustomStylesTheme.secondaryColor,
      tertiary: CustomStylesTheme.tertiaryColor,
    ),
    //appBarTheme: AppBarTheme(backgroundColor: CustomStylesTheme.primaryColor),
    // brightness: Brightness.light,
    // colorSchemeSeed: CustomStylesTheme.primaryColor,
    // applyElevationOverlayColor: false,
    // Define the default brightness and colors.
    // brightness: Brightness.dark,
    // primaryColor: CustomStylesTheme.primaryColor,

    useMaterial3: true,
    canvasColor: Colors.transparent,

    fontFamily: 'Roboto',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
      labelSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
      ),
    ),
    scaffoldBackgroundColor: kcBackgroundColor,
  );
}
