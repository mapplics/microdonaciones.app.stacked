import 'package:shared_preferences/shared_preferences.dart';

enum _Keys {
  appLocal,
}

class StorageHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Limpia del storage solo los datos que dependen del user logueado
  static Future<void> logoutClean() async {
    await _prefs.remove(_Keys.appLocal.name);
  }

  // static Future<bool> setGradientVersion(String gradientVersion) async {
  //   return await _prefs.setString(_Keys.gradientVersion.name, gradientVersion);
  // }

  // static String? getGradientVersion() {
  //   return _prefs.getString(_Keys.gradientVersion.name);
  // }
}
