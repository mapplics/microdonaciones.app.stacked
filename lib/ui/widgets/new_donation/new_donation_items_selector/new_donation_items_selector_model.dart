import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:stacked/stacked.dart';

class DonationItemsSelectorModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _newDonationDataService = locator<NewDonationDataService>();

  /// Devuelve la lista de items que se puede donar a la ONG.
  List<Product> get donationItemsOptions =>
      _newDonationDataService.productsOptions;

  /// Decide si el [product] se debe agregar/eliminar a la lista de [_selectedItems]
  /// El [value] indica si se debe agregar o eliminar el [product].
  void handleToggleDonation(bool value, Product product) {
    if (value) {
      _newDonationService.addDonationItem(product);
    } else {
      _newDonationService.removeDonationItem(product);
    }
  }

  /// Devuelve true si el item debe mostrarse como chequeado en la card.
  bool isSelectedItem(Product product) =>
      _newDonationService.checkIfItemExist(product);
}
