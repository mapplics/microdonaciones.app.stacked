import 'package:dio/dio.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/update_requests/update_user_request.model.dart';
import 'package:microdonations/core/models/user/auth.model.dart';
import 'package:microdonations/core/models/user/logged_user.model.dart';
import 'package:microdonations/services/auth_api_service.dart';
import 'package:microdonations/services/user_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';

import '../core/models/user/social_login_response.model.dart';

class AuthService with ListenableServiceMixin {
  final _authApi = locator<AuthApiService>();
  final _userApi = locator<UserApiService>();

  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Devuelve true si hay un usuario.
  bool get isUserLogged => (_loggedUser != null && _authModel != null);

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  /// Instancia del usuario logueado.
  LoggedUser? _loggedUser;

  /// Setea la instancia del usuario logueado.
  set setLoggedUser(LoggedUser user) => _loggedUser = user;

  /// Devuelve la instancia del usuario logueado.
  LoggedUser? get loggedUser => _loggedUser;

  /// Setea el [AuthModel] del usuario y lo guarda en el storage.
  void setAuthModel(String token) {
    _authModel = AuthModel(token: token);
    StorageHelper.saveAuthModel(_authModel!);
  }

  /// Loguea al usuario contra la API.
  Future<SocialLoginResponse> login(String email, String token) async {
    try {
      SocialLoginResponse response = await _authApi.login(email, token);
      setAuthModel(response.token);
      notifyListeners();
      return response;
    } on DioException catch (_) {
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

  //// Obtiene el perfil del usuario.
  Future<LoggedUser> getProfile() async {
    try {
      return await _userApi.getProfile();
    } catch (e) {
      rethrow;
    }
  }

  //// Actualizar los datos personales del usuario logueado.
  Future<void> updateProfile(UpdateUserRequest updateUserRequest) async {
    try {
      _loggedUser = await _userApi.updateProfile(updateUserRequest);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
