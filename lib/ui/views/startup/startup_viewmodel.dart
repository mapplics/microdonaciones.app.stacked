import 'package:microdonations/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/helpers/storage.helpers.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    /// Delay para que se muestre unos segundos el splash.
    await Future.delayed(const Duration(milliseconds: 1000));

    /// Inicializo el storage helper.
    await StorageHelper.init();

    /// Intento recuperar un usuario del Storage para hacer autologin.
    _authService.tryAutoLogin();

    if (true) {
      _navigationService.replaceWithOnboardingView();
    } else {
      /// Navego al home.
      _navigationService.replaceWithHomeView();
    }
  }
}
