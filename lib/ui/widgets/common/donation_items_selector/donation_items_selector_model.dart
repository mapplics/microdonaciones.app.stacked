import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class DonationItemsSelectorModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Indica si el widget esta cargando.
  bool _isLoading = true;

  /// Devuelve la lista de items que se puede donar a la ONG.
  List<Product> get donationItemsOptions => _newDonationService.productsOptions;

  /// Devuelve true si el widget deberia mostrar un loading.
  bool get isLoading => _isLoading;

  /// Decide si el [product] se debe agregar/eliminar a la lista de [_selectedItems]
  /// El [value] indica si se debe agregar o eliminar el [product].
  void handleToggleDonation(bool value, Product product) {
    if (value) {
      _newDonationService.addDonationItem(product);
    } else {
      _newDonationService.removeDonationItem(product);
    }
  }

  /// Recupera la lista de items que se pueden seleccionar para donar.
  Future<void> getDonationsItems() async {
    try {
      _isLoading = true;
      await _newDonationService.getOngDonationsItems();
    } catch (e) {
      logError('Error al setear los items.');
    } finally {
      _isLoading = false;
      rebuildUi();
    }
  }

  /// Devuelve true si el item debe mostrarse como chequeado en la card.
  bool isSelectedItem(Product product) =>
      _newDonationService.checkIfItemExist(product);
}
