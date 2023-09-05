import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:stacked/stacked.dart';

class DonationItemListDetailModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Devuelve los productos que selecciono el usuario para donar.
  List<DonationItem> get products => _newDonationService.selectedItems;

  /// Devuelve la cantidad total de productos que el usuario dono..
  int get totalProducts {
    int _totalProducts = 0;
    for (var product in _newDonationService.selectedItems) {
      _totalProducts += product.quantity;
    }
    return _totalProducts;
  }
}
