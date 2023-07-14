import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/ui/widgets/common/donation_items_selector/donation_items_selector.dart';
import 'package:stacked/stacked.dart';

class DonationItemsSelectorModel extends BaseViewModel {
  final OnChangeSelectedItems onchange;

  DonationItemsSelectorModel(this.onchange);

  /// Listado con los items de las donaciones que puede recibir la ONG.
  final List<DonationItem> _donationItems = [
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

  /// Representa la lista de items seleccionados que la persona va a donar.
  final List<DonationItem> selectedItems = [];

  /// Devuelve la lista de items que se puede donar a la ONG.
  List<DonationItem> get donationItems => _donationItems;

  /// Decide si el [item] se debe agregar/eliminar a la lista de [selectedItems]
  /// El [value] indica si se debe agregar o eliminar el [item].
  void handleToggleDonation(bool value, DonationItem item) {
    value ? _addDonation(item) : _removeDonation(item);
    onchange(selectedItems);
  }

  /// Agrega el [item] a la lista de donaciones [selectedItems].
  void _addDonation(DonationItem item) {
    selectedItems.add(item);
  }

  /// Remueve el [item] de la lista de donaciones [selectedItems].
  void _removeDonation(DonationItem item) {
    final index = selectedItems.indexOf(item);
    selectedItems.removeAt(index);
  }
}
