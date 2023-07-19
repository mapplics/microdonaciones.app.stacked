import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _donationItemApi = locator<DonationItemApiService>();

  /// Lista de items que la persona eligio para donar.
  List<DonationItem> _selectedItems = [];

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<DonationItem> _donationItemsOptions = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get donationItemsOptions => _donationItemsOptions;

  /// Devuelve los items que seleciono el usuario para donar
  List<DonationItem> get selectedItems => _selectedItems;

  /// Agrega el [item] a la lista de donaciones [_selectedItems].
  void addDonation(DonationItem item) {
    _selectedItems.add(item);
    notifyListeners();
  }

  /// Remueve el [item] de la lista de donaciones [_selectedItems].
  void removeDonation(DonationItem item) {
    final index = _selectedItems
        .indexWhere((selectedItem) => selectedItem.title == item.title);
    _selectedItems.removeAt(index);
    notifyListeners();
  }

  /// Setea una cantidad para el item [DonationItem] que se va a donar.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    final _found = _selectedItems
        .firstWhereOrNull((selectedItem) => selectedItem.title == item.title);

    /// Chequeo si encontr el item que quiero modificar
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
  bool checkIfItemExist(DonationItem item) {
    final _found = _selectedItems
        .firstWhereOrNull((selectedItem) => selectedItem.title == item.title);

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
      if (_donationItemsOptions.isEmpty) {
        _donationItemsOptions.addAll(await _donationItemApi.getDonationItems());
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _selectedItems = [];
    _donationItemsOptions = [];
  }
}
