import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/user/logged_user.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomAppbarModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  /// Devuelve true si deberia mostrar el avatar con las iniciales del user.
  bool get showAvatarWithInitials => _authService.isUserLogged;

  /// Devuelve instancia del usuario logueado, si es que existe uno.
  LoggedUser? get user => _authService.loggedUser;

  /// Navega a la pantalla de datos personales.
  void navigateToPersonalInformation() =>
      _navigationService.navigateToPersonalInformationView(
        viewParameters: UserInformationFormParameters(
          user: _authService.loggedUser!,
          showLogoutButton: (_authService.isUserLogged) ? true : false,
        ),
      );

  /// Navega a la pagina para que la persona se loguee
  void navigateToLogin() => _navigationService.navigateToLoginView();
}
