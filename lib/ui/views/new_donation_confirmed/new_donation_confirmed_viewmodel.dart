import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewDonationConfirmedViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goHome() {
    _navigationService.replaceWithHomeView();
  }
}
