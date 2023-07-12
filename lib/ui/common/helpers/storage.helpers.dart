import 'dart:convert';

import 'package:microdonations/core/models/auth.model.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Keys {
  authModel,
  seenOnboarding,
  loggedUser,
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
    final json = Map<String, dynamic>.from(
        jsonDecode(_prefs.getString(_Keys.authModel.name) ?? '{}'));

    return (json.isEmpty) ? null : AuthModel.fromJson(json);
  }

  /// Marca como visto o no el onboarding de  la app.
  static Future<bool> saveOnboarding(bool value) async {
    return await _prefs.setBool(_Keys.seenOnboarding.name, value);
  }

  /// Devuelve true/false si el usuario vio el onboarding de la app.
  static bool getSeenOnboarding() {
    return _prefs.getBool(_Keys.seenOnboarding.name) ?? false;
  }

  /// Recibe un usuario logueado [LoggedUser] y lo guarda en el storage.
  static Future<bool> saveLoggedUser(LoggedUser loggedUser) async {
    return await _prefs.setString(
      _Keys.loggedUser.name,
      jsonEncode(loggedUser.toJson()),
    );
  }

  /// Intenta recuperar un usuario logueado del storage.
  /// Devuelve un [LoggedUser] o null si no existe ningun usuario en el storage.
  static LoggedUser? getLoggedUser() {
    final json = Map<String, dynamic>.from(
        jsonDecode(_prefs.getString(_Keys.loggedUser.name) ?? '{}'));

    return (json.isEmpty) ? null : LoggedUser.fromJson(json);
  }
}
