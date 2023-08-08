import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => _userService.isUserLogged;

  /// Empieza el flujo para hacer una donacion.
  void startDonation() {
    /// Si el usuario no esta logueado le pedimos que se loguee.
    if (!_userService.isUserLogged) {
      _navigationService.navigateToLoginView();
    } else {
      _navigationService.navigateToMakeADonationView();
    }
  }
}
