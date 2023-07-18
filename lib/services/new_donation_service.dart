import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

class NewDonationService with ListenableServiceMixin {
  /// Lista de items que la persona eligio para donar.
  List<DonationItem> _selectedItems = [];

  /// Devuelve true si la persona no eligio ningun item para donar.
  bool get selectedItemsIsNotEmpty => _selectedItems.isNotEmpty;

  /// Devuelve los items que seleciono el usuario para donar
  List<DonationItem> get selectedItems => _selectedItems;

  /// Agrega el [item] a la lista de donaciones [_selectedItems].
  void addDonation(DonationItem item) {
    _selectedItems.add(item);
    notifyListeners();
  }

  /// Remueve el [item] de la lista de donaciones [_selectedItems].
  void removeDonation(DonationItem item) {
    final index =
        _selectedItems.indexWhere((element) => element.title == item.title);
    _selectedItems.removeAt(index);
    notifyListeners();
  }

  /// Setea una cantidad para el item [DonationItem] que se va a donar.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    final _found = _selectedItems
        .firstWhereOrNull((element) => element.title == item.title);

    if (_found != null) {
      _found.updateQuantity = quantity;
      replaceItem(_found);
    } else {
      logError('DonationItem not found!');
    }
  }

  /// Recibe un [DonationItem] y busca en [_selectedItems] una coincidencia
  /// si encuentra una lo reemplaza con el [item]
  void replaceItem(DonationItem item) {
    final index = _selectedItems.indexWhere(
      (element) => element.title == item.title,
    );

    if (index != -1) {
      _selectedItems[index] = item;
    } else {
      logError('No se encontro una coincidencia');
    }
  }

  /// Devuelve true si el [item] a donar existe en la lista de [_selectedItems]
  bool checkIfItemExist(DonationItem item) {
    final _found = _selectedItems
        .firstWhereOrNull((element) => element.title == item.title);

    return (_found != null);
  }

  /// Resetea todos todos los campos a su valor inicial.
  void resetNewDonation() {
    _selectedItems = [];
  }
}
