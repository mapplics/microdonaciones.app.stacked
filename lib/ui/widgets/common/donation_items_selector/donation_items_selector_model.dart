import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class DonationItemsSelectorModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Indica si el widget esta cargando.
  bool _isLoading = true;

  /// Listado con los items de las donaciones que puede recibir la ONG.
  final List<DonationItem> _donationItems = [];

  /// Devuelve la lista de items que se puede donar a la ONG.
  List<DonationItem> get donationItems => _donationItems;

  /// Devuelve true si el widget deberia mostrar un loading.
  bool get isLoading => _isLoading;

  /// Decide si el [item] se debe agregar/eliminar a la lista de [_selectedItems]
  /// El [value] indica si se debe agregar o eliminar el [item].
  void handleToggleDonation(bool value, DonationItem item) {
    if (value) {
      _newDonationService.addDonation(item);
    } else {
      _newDonationService.removeDonation(item);
    }
  }

  /// Devuelve true si el item debe mostrarse como chequeado en la card.
  bool isSelectedItem(DonationItem item) =>
      _newDonationService.checkIfItemExist(item);

  /// Recupera la lista de items que se pueden seleccionar para donar.
  Future<void> getDonationsItems() async {
    try {
      _isLoading = true;
      _donationItems.addAll(await _newDonationService.getDonationsItems());
    } catch (e) {
      logError('Error al setear los items.');
    } finally {
      _isLoading = false;
      rebuildUi();
    }
  }
}
