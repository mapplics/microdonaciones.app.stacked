import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:stacked/stacked.dart';

class NewDonationService with ListenableServiceMixin {
  /// Lista de items que la persona eligio para donar.
  List<DonationItem> _selectedItems = [];

  /// Recibe una lista de items para donar [DonationItem]
  /// y se la setea a [_selectedItems].
  void updateSelectedItems(List<DonationItem> items) {
    _selectedItems = items;
    notifyListeners();
  }

  /// Devuelve true si la persona no eligio ningun item para donar.
  bool get selectedItemsIsNotEmpty => _selectedItems.isNotEmpty;

  /// Resetea todos todos los campos a su valor inicial.
  void resetNewDonation() {
    _selectedItems = [];
  }
}
