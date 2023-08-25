import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/services/reception_api_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _donationItemApi = locator<DonationItemApiService>();
  final _receptionApi = locator<ReceptionApiService>();

  /// La ONG que eligio el usuario para hacer una donacion.
  final Ong _ongSelected = Ong(
    id: 1,
    name: 'Ong Test',
    web: '',
    mision: '',
    vision: '',
    phone: '',
    email: '',
    enabled: true,
  );

  /// Devuelve la ong seleccionada a la que se le va a hacer la donacion.
  Ong get ongSelected => _ongSelected;

  NewDonation _newDonation = NewDonation();

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<Product> _products = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<Product> get productsOptions => _products;

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<ReceptionPoint> _receptionPoints = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<ReceptionPoint> get receptionPoints => _receptionPoints;

  /// Contiene el rango de horarios que puede pasar a buscar las donaciones
  /// la ong [_ongSelected].
  List<PickupWeekDayRange> _pickupRange = [];

  /// Devuelve el rango de horarios que puede pasar a buscar las donaciones
  /// la ong [_ongSelected].
  List<PickupWeekDayRange> get pickupRange => _pickupRange;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get selectedItems => _newDonation.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  TypeDelivery get selectedTypeDelivery => _newDonation.typeDelivery;

  /// Recibe un [product] que se convierte a [DonationItem] que se agrega
  /// a la lista de donaciones [_selectedItems].
  void addDonationItem(Product product) {
    final asDonationItem = DonationItem.createFromProduct(product);
    _newDonation.addDonationItem(asDonationItem);
    notifyListeners();
  }

  /// Recibe un [Product] y busca una coincidencia en [_selectedItems].
  /// Si encuentra una elimina el [DonationItem] de [_selectedItems]
  void removeDonationItem(Product product) {
    _newDonation.removeDonationItem(product);
    notifyListeners();
  }

  /// Recibe un [DonationItem] y una cantidad [quantity]
  /// que se le va a asignar al mismo.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    _newDonation.updateDonationItemQuality(item, quantity);
    notifyListeners();
  }

  /// Actualiza el tipo de delivery que se va a usar para la donacion.
  void updateTypeDelivery(TypeDelivery type) {
    _newDonation.updateTypeDelivery(type);
  }

  /// Devuelve true si existe el [Product] en la lista de donacion.
  bool checkIfItemExist(Product product) =>
      _newDonation.checkIfItemExist(product);

  /// Devuelve null si la persona selecciono al menos un item para donar.
  /// Sino devuelve un [NewDonationError]
  NewDonationError? selectedItemsValid() {
    return _newDonation.donationsItemsList.isNotEmpty
        ? null
        : NewDonationError.noProductsSelected;
  }

  /// Devuelve null si todos los items de [_selectedItems]
  /// tienen una cantidad superior a 0.
  NewDonationError? itemsQuantityValid() {
    final _found = _newDonation.donationsItemsList.firstWhereOrNull(
      (selectedItem) =>
          (selectedItem.quantity == 0 && !selectedItem.quantity.isNegative),
    );

    return (_found == null) ? null : NewDonationError.quantityProductsInvalid;
  }

  /// Recupera la lista de items que se pueden seleccionar para donar.
  Future<void> getOngDonationsItems() async {
    try {
      /// Chequeo si tengo que recuperar los items para donar.
      if (_products.isEmpty) {
        _products.addAll(
          await _donationItemApi.getProductsByOng(_ongSelected),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Recupera la lista de puntos de entrega de la ong seleccionada [_ongSelected]
  Future<void> getReceptionPoints() async {
    try {
      _receptionPoints = await _receptionApi.getReceptionPoints(_ongSelected);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getPickupWeekdayTimeRange() async {
    try {
      _pickupRange = await _receptionApi.getWeekdayRangeTime(_ongSelected);
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _newDonation = NewDonation();
    _products = [];
    _receptionPoints = [];
    logSucess('Dispose newDonation');
  }
}
