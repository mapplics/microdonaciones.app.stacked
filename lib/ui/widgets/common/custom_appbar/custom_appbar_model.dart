import 'package:microdonations/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class CustomAppbarModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Navega a la pantalla de datos personales.
  void navigateToPersonalInformation() => {};
  // _navigationService.navigateToPersonalInformationView();
}
