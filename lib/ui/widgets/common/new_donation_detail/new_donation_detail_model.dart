import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:stacked/stacked.dart';

class NewDonationDetailModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Devuelve los productos que selecciono el usuario para donar.
  List<DonationItem> get products => _newDonationService.donationsItems;
}
