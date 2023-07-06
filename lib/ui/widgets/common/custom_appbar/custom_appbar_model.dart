import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../core/models/logged_user.model.dart';

class CustomAppbarModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Navega a la pantalla de datos personales.
  void navigateToPersonalInformation() =>
      _navigationService.navigateToPersonalInformationView(
        viewParameters: UserInformationFormParameters(
          LoggedUser(
            name: 'Gonzalo',
            surname: 'Etchegaray',
            address: 'San juan 1584',
          ),
        ),
      );
}
