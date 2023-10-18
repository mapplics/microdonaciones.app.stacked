import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OngSelectorCardModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Navega al flujo para hacer una donacion a la [ongSelected]
  void goToDonate(Ong ongSelected) {
    _navigationService.navigateToNewDonationView(ongSelected: ongSelected);
  }
}
