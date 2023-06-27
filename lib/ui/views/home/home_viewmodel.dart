import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  /// Desloguea al usuario y navega al login.
  Future<void> logout() async {
    await _authService.logout();
    _navigationService.replaceWithLoginView();
  }

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => _authService.isUserLogged;
}
