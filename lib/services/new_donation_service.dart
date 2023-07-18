import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

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

  /// Resetea todos todos los campos a su valor inicial.
  void resetNewDonation() {
    logWarn('Dispose');
    _selectedItems = [];
  }
}
