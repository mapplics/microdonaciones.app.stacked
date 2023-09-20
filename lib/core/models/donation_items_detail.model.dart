import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:collection/collection.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'product.model.dart';

class DonationItemsDetail {
  final List<DonationItem> _donationsList = [];

  /// Devuelve la lista de items [DonationItem] que el usuario selecciono
  /// para donar.
  List<DonationItem> get donationsItemsList => _donationsList;

  /// Recibe un [DonationItem] y lo agrega a [_donationsList]
  void addDonationItem(DonationItem donationItem) {
    _donationsList.add(donationItem);
  }

  /// Recibe un [Product] que se utiliza para buscar una
  /// coincidencia en [_donationsList] si se encuentra una coincidencia
  /// se elimina de la lista de [_donationsList]
  void removeDonationItem(Product product) {
    final _index = _donationsList.indexWhere(
      (selectedItem) => selectedItem.product.id == product.id,
    );

    _donationsList.removeAt(_index);
  }

  /// Recibe un [DonationItem] y la cantidad [quantity] que se le va a setear
  /// al mismo [DonationItem].
  void updateDonationItemQuality(DonationItem item, int quantity) {
    final _found = donationsItemsList.firstWhereOrNull(
      (selectedItem) => selectedItem.title == item.title,
    );

    /// Chequeo si encontre el item que quiero modificar
    if (_found != null) {
      _found.updateQuantity = quantity;
    } else {
      logError('DonationItem not found!');
    }
  }

  /// Devuelve true si existe un [DonationItem]
  /// en [_donationsList] para el [product].
  bool checkIfItemExist(Product product) {
    final _found = donationsItemsList.firstWhereOrNull(
        (selectedItem) => selectedItem.product.id == product.id);

    return (_found != null);
  }

  /// Devuelve true si algun item de la donacion tiene cero en la cantidad.
  bool checkEmptyItems() {
    final _found = _donationsList.firstWhereOrNull(
      (selectedItem) =>
          (selectedItem.quantity == 0 && !selectedItem.quantity.isNegative),
    );

    return (_found != null);
  }
}
