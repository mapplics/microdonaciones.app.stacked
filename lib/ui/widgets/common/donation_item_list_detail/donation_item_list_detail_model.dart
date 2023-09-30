import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:stacked/stacked.dart';

class DonationItemListDetailModel extends BaseViewModel {
  final List<DonationItem> donationItems;

  DonationItemListDetailModel(this.donationItems);

  /// Devuelve los productos que selecciono el usuario para donar.
  List<DonationItem> get products => donationItems;

  /// Devuelve la cantidad total de productos que el usuario dono..
  int get totalProducts {
    int _totalProducts = 0;
    for (var product in donationItems) {
      _totalProducts += product.quantity;
    }
    return _totalProducts;
  }
}
