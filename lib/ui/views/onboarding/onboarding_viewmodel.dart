import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Navega a la pantalla de home y la hace root.
  void navigateToHome() {
    /// Marco que se vio el onboarding para que no se vuelva a mostrar.
    StorageHelper.saveOnboarding(true);

    _navigationService.replaceWithHomeView();
  }
}
