import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => _authService.isUserLogged;

  /// Empieza el flujo para hacer una donacion.
  void startDonation() {
    _navigationService.navigateToOngSelectorView();
  }

  /// Navega a la pagina del historial de donaciones.
  void goToDonationHistory() {
    _navigationService.navigateToOrdersHistoryView();
  }

  /// Navega a la pantalla de about.
  navigateToAbout() {
    _navigationService.navigateToAboutView();
  }
}
