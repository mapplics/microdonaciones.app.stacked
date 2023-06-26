import 'package:microdonations/core/models/auth.model.dart';

import '../../ui/common/helpers/storage.helpers.dart';

class AuthService {
  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => (_authModel != null);

  /// Setea el [_authModel]
  void setAuthModel(String token) => _authModel = AuthModel(token: token);

  /// Devuelve el token del Google del [_authModel]
  get authToken => _authModel?.token ?? 'token-not-found';

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  /// Intenta recuperar un [AuthModel] del storage.
  void tryAutoLogin() {
    _authModel = StorageHelper.getAuthModel();
  }

  /// Hace el logout del usuario. Setea [_authoModel] en null
  /// y limpia el cache de la app.
  Future<void> logout() async {
    _authModel = null;
    await StorageHelper.logoutClean();
  }
}
