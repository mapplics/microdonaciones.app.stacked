import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/services/user_api_service.dart';
import 'package:stacked/stacked.dart';

import '../core/models/logged_user.model.dart';

class UserService with ListenableServiceMixin {
  final _userApi = locator<UserApiService>();

  /// Instancia del usuario logueado.
  LoggedUser? _loggedUser;

  /// Setea la instancia del usuario logueado.
  set setLoggedUser(LoggedUser user) => _loggedUser = user;

  /// Devuelve la instancia del usuario logueado.
  LoggedUser? get loggedUser => _loggedUser;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => (_loggedUser != null);

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
    } catch (e) {
      rethrow;
    }
  }
}
