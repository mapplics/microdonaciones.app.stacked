import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/user/auth.model.dart';
import 'package:microdonations/services/auth_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';

import '../core/models/user/social_login_response.model.dart';

class AuthService with ListenableServiceMixin {
  final _authApi = locator<AuthApiService>();

  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Setea el [AuthModel] del usuario y lo guarda en el storage.
  void setAuthModel(String token) {
    _authModel = AuthModel(token: token);
    StorageHelper.saveAuthModel(_authModel!);
  }

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  bool get isUserLogged => (_authModel != null);

  /// Loguea al usuario contra la API.
  Future<SocialLoginResponse> login(String email, String token) async {
    try {
      SocialLoginResponse response = await _authApi.login(email, token);
      setAuthModel(response.token);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Hace el logout del usuario.
  Future<void> logout() async {
    await clearAuth();
  }

  /// Setea [_authModel] en null y limpia el Storage.
  Future<void> clearAuth() async {
    _authModel = null;
    await StorageHelper.logoutClean();
    notifyListeners();
  }

  /// Intenta loguear al usuario recuperando un [AuthModel] del storage.
  void tryAutoLogin() {
    try {
      _authModel = StorageHelper.getAuthModel();
    } catch (e) {
      logError('No se pudo recuperar el AuthModel');
    }
  }
}
