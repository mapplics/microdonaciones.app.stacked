import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/services/user_api_service.dart';

import '../core/models/logged_user.model.dart';

class UserService {
  final _userApi = locator<UserApiService>();

  /// Instancia del usuario logueado.
  late LoggedUser _loggedUser;

  /// Setea la instancia del usuario logueado.
  set setLoggedUser(LoggedUser user) => _loggedUser = user;

  /// Devuelve la instancia del usuario logueado.
  LoggedUser get loggedUser => _loggedUser;

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
      await _userApi.updateProfile(updateUserRequest);
    } catch (e) {
      rethrow;
    }
  }
}
