import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/auth.model.dart';
import 'package:microdonations/services/auth_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';

import '../core/models/social_login_response.model.dart';

class AuthService with ListenableServiceMixin {
  final _authApi = locator<AuthApiService>();

  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Setea el [AuthModel] del usuario.
  void setAuthModel(String token) => (_authModel = AuthModel(token: token));

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  /// Intenta loguear al usuario recuperando un [AuthModel] del storage.
  void tryAutoLogin() {
    try {
      _authModel = StorageHelper.getAuthModel();
    } catch (e) {
      logError('No se pudo recuperar el AuthModel');
    }
  }

  /// Loguea al usuario contra la API.
  Future<SocialLoginResponse> login(String email, String token) async {
    try {
      final _loginResp = await _authApi.login(email, token);
      setAuthModel(_loginResp.token);
      return _loginResp;
    } catch (e) {
      rethrow;
    }
  }

  /// Hace el logout del usuario. Setea [_authoModel] en null
  /// y limpia el cache de la app.
  Future<void> logout() async {
    _authModel = null;
    await StorageHelper.logoutClean();
    notifyListeners();
  }
}
