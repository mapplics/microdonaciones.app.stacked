import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
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

  /// Lista de items que la persona eligio para donar.
  List<DonationItem> _selectedItems = [];

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<Product> _products = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<Product> get productsOptions => _products;

  /// Devuelve los items que seleciono el usuario para donar
  List<DonationItem> get selectedItems => _selectedItems;

  /// Agrega el [product] a la lista de donaciones [_selectedItems].
  void addDonationItem(Product product) {
    final asDonationItem = DonationItem.createFromProduct(product);
    _selectedItems.add(asDonationItem);
    notifyListeners();
  }

  /// Remueve el [product] de la lista de donaciones [_selectedItems].
  void removeDonationItem(Product product) {
    final index = _selectedItems
        .indexWhere((selectedItem) => selectedItem.product.id == product.id);
    _selectedItems.removeAt(index);
    notifyListeners();
  }

  /// Setea una cantidad para el item [DonationItem] que se va a donar.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    final _found = _selectedItems
        .firstWhereOrNull((selectedItem) => selectedItem.title == item.title);

    /// Chequeo si encontre el item que quiero modificar
    if (_found != null) {
      _found.updateQuantity = quantity;
      _replaceItem(_found);
    } else {
      logError('DonationItem not found!');
    }

    notifyListeners();
  }

  /// Recibe un [DonationItem] y busca en [_selectedItems] una coincidencia
  /// si encuentra una lo reemplaza con el [item]
  void _replaceItem(DonationItem item) {
    final index = _selectedItems.indexWhere(
      (selectedItem) => selectedItem.title == item.title,
    );

    /// Chequeo si encontre el item que quiero reemplazar.
    if (index != -1) {
      _selectedItems[index] = item;
    } else {
      logError('No se encontro una coincidencia');
    }
  }

  /// Devuelve true si el [item] a donar existe en la lista de [_selectedItems]
  bool checkIfItemExist(Product product) {
    final _found = _selectedItems.firstWhereOrNull(
        (selectedItem) => selectedItem.product.id == product.id);

    return (_found != null);
  }

  /// Devuelve true si la persona selecciono al menos un item para donar.
  bool selectedItemsValid() => _selectedItems.isNotEmpty;

  /// Devuelve true si todos los items de [_selectedItems]
  /// tienen una cantidad distinta de 0.
  bool itemsQuantityValid() {
    final _found = _selectedItems
        .firstWhereOrNull((selectedItem) => selectedItem.quantity == 0);

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
    _selectedItems = [];
    _products = [];
  }
}
