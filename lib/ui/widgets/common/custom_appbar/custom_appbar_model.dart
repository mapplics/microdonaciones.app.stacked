import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class CustomAppbarModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _authService = locator<AuthService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  /// Devuelve true si deberia mostrar el avatar con las iniciales del user.
  bool get showAvatarWithInitials => _userService.haveUser;

  LoggedUser? get user => _userService.loggedUser;

  /// Navega a la pantalla de datos personales.
  void navigateToPersonalInformation() =>
      _navigationService.navigateToPersonalInformationView(
        viewParameters: UserInformationFormParameters(
          user: _userService.loggedUser!,
          showLogoutButton: (_userService.haveUser) ? true : false,
        ),
      );

  /// Navega a la pagina para que la persona se loguee
  void navigateToLogin() => _navigationService.navigateToLoginView();
}
