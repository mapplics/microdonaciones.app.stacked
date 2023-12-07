
import 'dart:ui';

class ConstantData {
  static String themeMode = 'themeMode';
  static String apiToken = 'API_TOKEN';
  static String userId = 'USER_ID';
  static String userEmail = 'USER_EMAIL';
  static String eventNotificationID = '0';
  static String deviceToken = 'DEVICE_TOKEN';

  static String assetsPath = "assets/img/";
  static Color primaryColor = "#0098d9".toColor();
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}