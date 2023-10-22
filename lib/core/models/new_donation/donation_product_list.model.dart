import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:collection/collection.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import '../ong/ong_product.model.dart';

/// Representa la lista de productos que se le va a donar a la ONG.
class DonationProductList {
  final List<DonationProduct> _donationProductList = [];

  /// Devuelve la lista de productos que el usuario selecciono para donar.
  List<DonationProduct> get donationsItemsList => _donationProductList;

  /// Recibe un [DonationProduct] y lo agrega a [_donationProductList]
  void addDonationItem(DonationProduct donationItem) {
    _donationProductList.add(donationItem);
  }

  /// Recibe un [OngProduct] y lo elimina de la lista de donaciones.
  void removeDonationItem(OngProduct product) {
    final _index = _donationProductList.indexWhere(
      (selectedItem) => selectedItem.product.id == product.id,
    );

    _donationProductList.removeAt(_index);
  }

  /// Recibe un [DonationProduct] y una nueva cantidad [quantity] para asignarle.
  void updateDonationItemQuality(DonationProduct item, int quantity) {
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

  /// Devuelve true si el [product] exista en la lista de productos a donar.
  bool checkIfItemExist(OngProduct product) {
    final _found = donationsItemsList.firstWhereOrNull(
        (selectedItem) => selectedItem.product.id == product.id);

    return (_found != null);
  }

  /// Devuelve true si alguno de los productos a donar
  /// de la lista [_donationProductList] no tiene una cantidad asignada.
  bool checkEmptyItems() {
    final _found = _donationProductList.firstWhereOrNull(
      (selectedItem) =>
          (selectedItem.quantity == 0 && !selectedItem.quantity.isNegative),
    );

    return (_found != null);
  }
}
