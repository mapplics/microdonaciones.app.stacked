import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authService,
        _userService,
      ];

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => _authService.isUserLogged;

  /// Empieza el flujo para hacer una donacion.
  void startDonation() {
    /// Si el usuario no esta logueado le pedimos que se loguee.
    if (!_authService.isUserLogged) {
      _navigationService.navigateToLoginView();
    } else {
      _navigationService.navigateToOngSelectorView();
    }
  }

  void goToDonationHistory() {
    _navigationService.navigateToOrdersHistoryView();
  }
}
