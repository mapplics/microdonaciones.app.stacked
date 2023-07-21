import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _donationItemApi = locator<DonationItemApiService>();

  /// La ONG que eligio el usuario para hacer una donacion.
  final Ong _ongSelected = Ong(
    id: 1,
    name: 'Ong Test',
    web: '',
    mision: '',
    vision: '',
    phone: '',
    email: '',
    enabled: true,
  );

  NewDonation _newDonation = NewDonation();

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<Product> _products = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<Product> get productsOptions => _products;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get selectedItems => _newDonation.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  TypeDelivery get selectedTypeDelivery => _newDonation.typeDelivery;

  /// Recibe un [product] que se convierte a [DonationItem] que se agrega
  /// a la lista de donaciones [_selectedItems].
  void addDonationItem(Product product) {
    final asDonationItem = DonationItem.createFromProduct(product);
    _newDonation.addDonationItem(asDonationItem);
    notifyListeners();
  }

  /// Recibe un [Product] y busca una coincidencia en [_selectedItems].
  /// Si encuentra una elimina el [DonationItem] de [_selectedItems]
  void removeDonationItem(Product product) {
    _newDonation.removeDonationItem(product);
    notifyListeners();
  }

  /// Recibe un [DonationItem] y una cantidad [quantity]
  /// que se le va a asignar al mismo.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    _newDonation.updateDonationItemQuality(item, quantity);
    notifyListeners();
  }

  void updateTypeDelivery(TypeDelivery type) {
    _newDonation.updateTypeDelivery(type);
  }

  /// Devuelve true si existe el [Product] en la lista de donacion.
  bool checkIfItemExist(Product product) =>
      _newDonation.checkIfItemExist(product);

  /// Devuelve true si la persona selecciono al menos un item para donar.
  bool selectedItemsValid() => _newDonation.donationsItemsList.isNotEmpty;

  /// Devuelve true si todos los items de [_selectedItems]
  /// tienen una cantidad distinta de 0.
  bool itemsQuantityValid() {
    final _found = _newDonation.donationsItemsList.firstWhereOrNull(
      (selectedItem) => (selectedItem.quantity == 0),
    );

    return (_found == null);
  }

  /// Recupera la lista de items que se pueden seleccionar para donar.
  Future<void> getOngDonationsItems() async {
    try {
      /// Chequeo si tengo que recuperar los items para donar.
      if (_products.isEmpty) {
        _products.addAll(
          await _donationItemApi.getProductsByOng(_ongSelected),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _newDonation = NewDonation();
    _products = [];
  }
}
