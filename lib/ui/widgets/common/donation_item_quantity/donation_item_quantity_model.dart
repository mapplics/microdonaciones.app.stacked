import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:stacked/stacked.dart';

class DonationItemQuantityModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>;

  /// Contiene los items que seleciono el usuario para donar.
  List<DonationItem> selectedItems = [];

  /// Recupera la lista de items [DonationItem] que seleciono
  /// el usuario para donar del [NewDonationService].
  List<DonationItem> getSelectedItems() =>
      selectedItems = _newDonationService.call().donationsItems;

  /// Devuelve true si es el primer item de la lista de [selectedItems].
  /// Lo usamos para saber si tenemos que mostrar un divider al final
  /// de la lista de items.
  bool shouldShoWFirstDivider(int index) => (index == 0);

  /// Devuelve true si es el ultimo item de la lista de [selectedItems].
  /// Lo usamos para saber si tenemos que mostrar un divider al final
  /// de la lista de items.
  bool shouldShowLastDivider(int index) => (index == selectedItems.length - 1);

  /// Setea la cantidad que se va a donar del item [DonationItem]
  void updateItemQuantity(DonationItem item, int quantity) =>
      _newDonationService.call().onChangeItemQuantity(item, quantity);
}
