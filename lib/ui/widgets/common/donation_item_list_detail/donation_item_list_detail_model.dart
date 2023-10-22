import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:stacked/stacked.dart';

class DonationItemListDetailModel extends BaseViewModel {
  final List<DonationProduct> donationItems;

  DonationItemListDetailModel(this.donationItems);

  /// Devuelve la cantidad total de productos que el usuario dono..
  int get totalProducts {
    int _totalProducts = 0;
    for (var product in donationItems) {
      _totalProducts += product.quantity;
    }
    return _totalProducts;
  }
}
