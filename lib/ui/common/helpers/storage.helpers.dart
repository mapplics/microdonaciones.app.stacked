import 'dart:convert';

import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/auth.model.dart';

enum _Keys {
  authModel,
}

class StorageHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Limpia del storage solo los datos que dependen del user logueado.
  static Future<void> logoutClean() async {
    await _prefs.remove(_Keys.authModel.name);
  }

  /// Recibe un [AuthModel] y lo guarda en el storage.
  static Future<bool> saveAuthModel(AuthModel authModel) async {
    return await _prefs.setString(
      _Keys.authModel.name,
      jsonEncode(AuthModel.toJson(authModel)),
    );
  }

  /// Recupera un [AuthModel] del storage.
  /// Si no encuentra ninguno devuelve null.
  static AuthModel? getAuthModel() {
    final authAsString = _prefs.getString(_Keys.authModel.name);

    try {
      return AuthModel.fromJson(jsonDecode(authAsString!));
    } catch (e) {
      logError(
          '<StorageHelper> No se pudo recuperar el authModel del storage $e');
      return null;
    }
  }
}
