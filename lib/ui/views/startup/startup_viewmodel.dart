import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    /// Si estoy logueado navego al home. Sino voy al login.
    if (_authService.isUserLogged) {
      logSucess('El usuario ya se encontraba logueado.');
      _navigationService.replaceWithHomeView();
    } else {
      logInfo('El usuario no se encuentra logueado.');
      _navigationService.replaceWithLoginView();
    }
  }
}
