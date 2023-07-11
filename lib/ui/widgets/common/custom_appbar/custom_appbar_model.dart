import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class CustomAppbarModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  /// Navega a la pantalla de datos personales.
  void navigateToPersonalInformation() =>
      _navigationService.navigateToPersonalInformationView(
        viewParameters: UserInformationFormParameters(_userService.loggedUser),
      );
}
