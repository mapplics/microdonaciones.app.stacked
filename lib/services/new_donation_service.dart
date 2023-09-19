import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/services/new_donation_api_service.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _newDonationData = locator<NewDonationDataService>();
  final _newDonationApi = locator<NewDonationApiService>();

  NewDonation? _newDonation;

  FormGroup? _pickupAppointmentForm;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get selectedItems => _newDonation!.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  UserAddress? get userAddres => _newDonation!.userAddressValue;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  TypeDelivery get selectedTypeDelivery => _newDonation!.typeDelivery;

  /// Devuelve una instancia con los id's que selecciono el usuario para que le
  /// retiren la donacion.
  PickupDropdownValue? get pickupValue => _newDonation!.pickupValue;

  /// Devuelve una instancia de [PickupWeekDayRangePresentation] que permite
  /// detallar la hora y dia que el usuario selecciono para que retiren
  /// su donación.
  PickupWeekDayRangePresentation? get pickupPresentation {
    if (_newDonation!.pickupValue == null) {
      return null;
    } else {
      final pickupRange = _newDonationData.pickupRange;

      return PickupWeekDayRangePresentation.createOne(
        pickupRange,
        _newDonation!.pickupValue!,
      );
    }
  }

  /// Devuelve el tipo de delivery que eligio el donante.
  TypeDelivery get deliveryTypeValue => _newDonation!.typeDelivery;

  /// Devuelve el punto de entrega, si es que el usuario selecciono uno.
  ReceptionPoint? get receptionPointValue => _newDonation!.receptionPointValue;

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

  void updatePickUpAppointmentForm(FormGroup form) =>
      _pickupAppointmentForm = form;

  FormGroup? get pickupAppointmentForm => _pickupAppointmentForm;

  void resetPickupAppointmentForm() {
    _pickupAppointmentForm = null;
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

  /// Crea una donacion.
  Future<void> createDontaion() async {
    try {
      if (_newDonation != null) {
        await _newDonationApi.createDonation(_newDonation!);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _newDonation = null;
    _newDonationData.resetNewDonationData();
    resetPickupAppointmentForm();
    logSucess('Dispose newDonation');
  }
}
