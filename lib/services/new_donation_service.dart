import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _newDonationData = locator<NewDonationDataService>();

  NewDonation? _newDonation;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get selectedItems => _newDonation!.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  TypeDelivery get selectedTypeDelivery => _newDonation!.typeDelivery;

  PickupDropdownValue? get pickupValue => _newDonation!.pickupValue;

  /// Inicializa el proceso de donacion.
  /// Siempre se debe llamar este metodo antes que cualquier otro.
  Future<void> initNewDonationData(Ong ong) async {
    try {
      /// Creo instancia de donacion.
      _newDonation = NewDonation(ong: ong);

      /// Seteo la ong para recuperar datos de la misma.
      _newDonationData.setOng = ong;

      /// Cargo toda la data necesaria.
      await Future.wait([
        _newDonationData.getOngDonationsItems(),
        _newDonationData.getReceptionPoints(),
        _newDonationData.getPickupWeekdayTimeRange(),
      ]);
    } catch (e) {
      logError('Fallo la carga de datos!!');
      rethrow;
    }
  }

  /// Recibe un [product] que se convierte a [DonationItem] que se agrega
  /// a la lista de donaciones [_selectedItems].
  void addDonationItem(Product product) {
    final asDonationItem = DonationItem.createFromProduct(product);
    _newDonation!.addDonationItem(asDonationItem);
    notifyListeners();
  }

  /// Recibe un [Product] y busca una coincidencia en [_selectedItems].
  /// Si encuentra una elimina el [DonationItem] de [_selectedItems]
  void removeDonationItem(Product product) {
    _newDonation!.removeDonationItem(product);
    notifyListeners();
  }

  /// Recibe un [DonationItem] y una cantidad [quantity]
  /// que se le va a asignar al mismo.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    _newDonation!.updateDonationItemQuality(item, quantity);
    notifyListeners();
  }

  /// Actualiza el tipo de delivery que se va a usar para la donacion.
  void updateTypeDelivery(TypeDelivery type) {
    _newDonation!.updateTypeDelivery(type);
  }

  /// Actualiza el punto de entrega de la donacion.
  void updateReceptionPoint(ReceptionPoint receptionPoint) {
    _newDonation!.receptionPoint = receptionPoint;
  }

  /// Resetea el punto de entrega de la donacion.
  void resetReceptionPoint() {
    _newDonation!.resetReceptionPoint();
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void updatePickupValue(PickupDropdownValue pickupValue) {
    _newDonation!.setPickupValue = pickupValue;
  }

  /// Resetea el horario de retiro de la donacion por domicilio.
  void resetPickupValue() {
    _newDonation!.resetPickupValue();
  }

  /// Actualiza la direccion del donante de retiro de la donacion por domicilio.
  void updateUserAddres(UserAddress userAddres) {
    _newDonation!.userAddress = userAddres;
  }

  /// Resetea la direccion del donante de retiro de la donacion por domicilio.
  void resetUserAddres() {
    _newDonation!.resetUserAddress();
  }

  /// Devuelve true si existe el [Product] en la lista de donacion.
  bool checkIfItemExist(Product product) =>
      _newDonation!.checkIfItemExist(product);

  /// Devuelve null si la persona selecciono al menos un item para donar.
  /// Sino devuelve un [NewDonationError]
  NewDonationError? selectedItemsValid() {
    return _newDonation!.donationsItemsList.isNotEmpty
        ? null
        : NewDonationError.noProductsSelected;
  }

  /// Devuelve null si todos los items de [_selectedItems]
  /// tienen una cantidad superior a 0.
  NewDonationError? itemsQuantityValid() {
    final _found = _newDonation!.donationsItemsList.firstWhereOrNull(
      (selectedItem) =>
          (selectedItem.quantity == 0 && !selectedItem.quantity.isNegative),
    );

    return (_found == null) ? null : NewDonationError.quantityProductsInvalid;
  }

  /// Devuelve null si el metodo de entrega de la donacion es valido.
  NewDonationError? deliveryValid() {
    if (_newDonation!.typeDelivery == TypeDelivery.delivery) {
      return (_newDonation!.pickupValue == null)
          ? NewDonationError.pickupRangeInvalid
          : null;
    } else {
      return null;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _newDonation = null;
    _newDonationData.resetNewDonationData();
    logSucess('Dispose newDonation');
  }
}
