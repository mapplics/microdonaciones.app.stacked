import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class DonationItemsSelectorModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

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

  /// Devuelve la lista de items que se puede donar a la ONG.
  List<DonationItem> get donationItems => _donationItems;

  /// Decide si el [item] se debe agregar/eliminar a la lista de [_selectedItems]
  /// El [value] indica si se debe agregar o eliminar el [item].
  void handleToggleDonation(bool value, DonationItem item) {
    value
        ? _newDonationService.addDonation(item)
        : _newDonationService.removeDonation(item);
  }

  /// Devuelve true si el item [DonationItem]
  /// esta dentro de la lista de [_selectedItems]
  bool isSelectedItem(DonationItem item) {
    final found = _newDonationService.selectedItems.contains(item);
    logSucess('${item.title} $found');
    return found;
  }
}
