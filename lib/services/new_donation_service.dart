import 'package:microdonations/core/models/donation_item.model.dart';
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
    final index = _selectedItems.indexOf(item);
    _selectedItems.removeAt(index);
    notifyListeners();
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
