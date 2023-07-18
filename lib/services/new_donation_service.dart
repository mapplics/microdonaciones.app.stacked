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

    notifyListeners();
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

  /// Devuelve true si todos los items de [_selectedItems]
  /// tienen una cantidad distinta de 0.
  bool get itemsQuantityValid {
    final _found =
        _selectedItems.firstWhereOrNull((item) => item.quantity == 0);

    return (_found == null);
  }

  /// Recupera de la API la lista de items que se puede donar para la ONG.
  Future<List<DonationItem>> getDonationsItems() async {
    try {
      return await Future.delayed(const Duration(seconds: 1), () {
        return [
          DonationItem(
            title: 'Arroz',
            pathImg: 'assets/img/img_arroz.png',
          ),
          DonationItem(
            title: 'Fideos',
            pathImg: 'assets/img/img_fideos.png',
          ),
          DonationItem(
            title: 'Leche en polvo',
            pathImg: 'assets/img/img_leche_en_polvo.png',
          ),
          DonationItem(
            title: 'Latas en conserva',
            pathImg: 'assets/img/img_latas_de_conserva.png',
          ),
        ];
      });
    } catch (e) {
      logError('Get donations items failed ${e.toString()}');
      rethrow;
    }
  }
}
