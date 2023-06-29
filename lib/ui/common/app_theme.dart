import 'package:flutter/material.dart';

class CustomStylesTheme {
  /// Colors
  ///
  ///
  static const MaterialColor primaryColor = MaterialColor(
    0xFFFF1494, // primary
    <int, Color>{
      50: Color(0xFFFF1494),
      100: Color(0xFFFF1494),
      200: Color(0xFFFF1494),
      300: Color(0xFFFF1494),
      400: Color(0xFFFF1494),
      500: Color(0xFFFF1494),
      600: Color(0xFFFF1494),
      700: Color(0xFFFF1494),
      800: Color(0xFFFF1494),
      900: Color(0xFFFF1494),
    },
  );

  static const Color tertiaryColor = Color(0xff4C51C6);
  static const Color secondaryColor = Color(0xff6F8BF4);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color darkGreyColor = Color(0xFF808080);
  static const Color lightGreyColor = Color(0xFF606060);
  static const Color gray100 = Color(0xFFb5b5b5);
  static const Color gray200 = Color(0xFFd4d4d4);
  static const Color blackColor = Color(0xFF000000);

  /// Logger colors
  static const Color sucessColor = Color(0xff82DB91);
  static const Color warningColor = Color(0xffF3AD5A);
  static const Color errorColor = Color(0xffFF896F);

  /// Utilizar iconos Thin con este tamaño
  /// 16px
  static const iconSizeSm = 16.0;

  /// Utilizar iconos Light con este tamaño
  /// 24px
  static const iconSizeLg = 24.0;

  /// Utilizar iconos Regular con este tamaño
  /// 32px
  static const iconSizeXl = 32.0;

  /// Text Styles
  ///
  /// Untitled Sans Styles
  static const regular24_32 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    height: 1.33,
    letterSpacing: 0,
  );
  static const regular24_28 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    height: 1.16,
    letterSpacing: 0,
  );
  static const regular20_28 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: 0,
  );
  static const regular20_24 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.2,
    letterSpacing: 0,
  );
  static const regular20_32 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.6,
    letterSpacing: 0,
  );
  static const regular18_24 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0,
  );
  static const regular16_26 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.8,
    letterSpacing: 0,
  );
  static const regular16_24 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0,
  );
  static const regular16_20 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.25,
    letterSpacing: 0,
  );
  static const regular16_14 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.14,
    letterSpacing: 0,
  );
  static const regular15_16 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.14,
    letterSpacing: 0,
  );
  static const regular14_20 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43,
    letterSpacing: 0,
  );
  static const regular14_24 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.71,
    letterSpacing: 0,
  );
  static const regular14_16 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.14,
    letterSpacing: 0,
  );
  static const regular12_20 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.66,
    letterSpacing: 0,
  );
  static const regular12_32 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.33,
    letterSpacing: 0,
  );
  static const regular12_16 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.33,
    letterSpacing: 0,
  );
  static const regular12_24 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 2,
    letterSpacing: 0,
  );

  static const regular10_16 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 1.6,
    letterSpacing: 0,
  );
  static const regular10_12 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 1.2,
    letterSpacing: 0,
  );
  static const regular10_20 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 2,
    letterSpacing: 0,
  );
  static const regular26_40 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.normal,
    height: 1.54,
    letterSpacing: 0,
  );

  static const bold34_44 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 1.29,
    letterSpacing: 0,
  );
  static const bold32_40 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.23,
    letterSpacing: 0,
  );
  static const bold28_32 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.14,
    letterSpacing: 0,
  );
  static const bold26_32 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.23,
    letterSpacing: 0,
  );
  static const bold26_28 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.08,
    letterSpacing: 0,
  );
  static const bold24_32 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: 0,
  );
  static const bold24_28 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.16,
    letterSpacing: 0,
  );
  static const bold20_28 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.8,
    letterSpacing: 0,
  );
  static const bold20_24 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0,
  );
  static const bold16_24 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5);
  static const bold16_20 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: 0,
  );
  static const bold14_20 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.43,
    letterSpacing: 0,
  );
  static const bold14_24 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.71,
    letterSpacing: 0,
  );
  static const bold14_16 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.14,
    letterSpacing: 0,
  );
  static const bold12_20 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.66,
    letterSpacing: 0,
  );
  static const bold12_16 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: 0,
  );

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
      displayLarge: CustomStylesTheme.regular24_28,
      displayMedium: CustomStylesTheme.regular20_24,
      displaySmall: CustomStylesTheme.regular16_20,
      headlineMedium: CustomStylesTheme.regular14_16,
      headlineSmall: CustomStylesTheme.regular12_16,
      titleLarge: CustomStylesTheme.regular10_12,
      bodyLarge: CustomStylesTheme.bold24_28,
      bodyMedium: CustomStylesTheme.bold20_24,
      titleMedium: CustomStylesTheme.bold16_24,
      titleSmall: CustomStylesTheme.bold16_20,
    ),
    scaffoldBackgroundColor: CustomStylesTheme.backgroundColor,
  );
}
