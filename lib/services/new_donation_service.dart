import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/pickup_new_donation.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/services/new_donation_api_service.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:microdonations/ui/widgets/common/pickup_appointment_form/pickup_appointment_form_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _newDonationData = locator<NewDonationDataService>();
  final _newDonationApi = locator<NewDonationApiService>();

  DonationItemsDetail _donationItems = DonationItemsDetail();

  TypeDelivery _deliveryType = TypeDelivery.pickup;

  DeliveryNewDonation? _deliveryDonation;

  PickupNewDonation? _pickupDonation;

  FormGroup? _pickupAppointmentForm;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get donationsItems => _donationItems.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  UserAddress? get userAddres => _deliveryDonation?.userAddress;

  /// Devuelve una instancia con los id's que selecciono el usuario para que le
  /// retiren la donacion.
  // PickupDropdownValue? get pickupValue => _newDonation!.pickupValue;

  /// Devuelve una instancia de [PickupWeekDayRangePresentation] que permite
  /// detallar la hora y dia que el usuario selecciono para que retiren
  /// su donación.
  PickupWeekDayRangePresentation? get pickupPresentation {
    final pickupRange = _newDonationData.pickupRange;

    return PickupWeekDayRangePresentation.createOne(
      pickupRange,
      _deliveryDonation!,
    );
  }

  /// Inicializa el proceso de donacion.
  /// Siempre se debe llamar este metodo antes que cualquier otro.
  Future<void> initNewDonationData(Ong ong) async {
    try {
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
    _donationItems.addDonationItem(asDonationItem);
    notifyListeners();
  }

  /// Recibe un [Product] y busca una coincidencia en [_selectedItems].
  /// Si encuentra una elimina el [DonationItem] de [_selectedItems]
  void removeDonationItem(Product product) {
    _donationItems.removeDonationItem(product);
    notifyListeners();
  }

  /// Recibe un [DonationItem] y una cantidad [quantity]
  /// que se le va a asignar al mismo.
  void onChangeItemQuantity(DonationItem item, int quantity) {
    _donationItems.updateDonationItemQuality(item, quantity);
    notifyListeners();
  }

  /// Devuelve el tipo de delivery que eligio el donante.
  TypeDelivery get deliveryTypeValue => _deliveryType;

  /// Actualiza el tipo de delivery que se va a usar para la donacion.
  void updateTypeDelivery(TypeDelivery type) {
    _deliveryType = type;

    if (TypeDelivery.delivery == type) {
      _deliveryDonation = DeliveryNewDonation();
      _pickupDonation = null;
    } else {
      _pickupDonation = PickupNewDonation();
      _deliveryDonation = null;
    }
  }

  /// Devuelve el punto de entrega, si es que el usuario selecciono uno.
  ReceptionPoint? get receptionPointValue => _pickupDonation?.receptionPoint;

  /// Actualiza el punto de entrega de la donacion.
  void updateReceptionPoint(ReceptionPoint receptionPoint) {
    _pickupDonation!.setReceptionPoint = receptionPoint;
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void _updatePickupRange(PickupDropdownValue pickupValue) {
    _deliveryDonation!.setRangeId = pickupValue.rangeTimeId;
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void _updatePickupWeekday(PickupDropdownValue pickupValue) {
    _deliveryDonation!.setWeekdayId = pickupValue.weekdayId;
  }

  /// Actualiza el que se le va a retirar la donacion.
  void _updatePickupDate(DateTime date) {
    _deliveryDonation!.setPickupDate = date;
  }

  /// Actualiza la direccion del donante de retiro de la donacion por domicilio.
  void updateUserAddres(UserAddress userAddres) {
    _deliveryDonation!.setUserAddress = userAddres;
  }

  /// Devuelve el formulario de delivery [_pickupAppointmentForm]
  FormGroup? get pickupAppointmentForm => _pickupAppointmentForm;

  /// Devuelve true si el formulario delivery es valid [_pickupAppointmentForm]
  bool get pickupAppointmentFormValid => _pickupAppointmentForm?.valid ?? false;

  /// Actualiza el formulario de delivery [_pickupAppointmentForm]
  void updatePickUpAppointmentForm(FormGroup form) {
    _pickupAppointmentForm = form;

    if (_pickupAppointmentForm?.valid ?? false) {
      final dayValue = ReactiveFormHelper.getControlValue(
          _pickupAppointmentForm!, PickupAppointmentFormFields.day.name);
      final pickupValue = ReactiveFormHelper.getControlValue(
              _pickupAppointmentForm!, PickupAppointmentFormFields.time.name)
          as PickupDropdownValue;

      _updatePickupRange(pickupValue);
      _updatePickupWeekday(pickupValue);
      _updatePickupDate(dayValue);
    }
  }

  /// Limpia el formulario de delivery [_pickupAppointmentForm]
  void resetPickupAppointmentForm() {
    _pickupAppointmentForm = null;
  }

  ///
  String get deliveryDetail {
    if (_pickupAppointmentForm?.invalid ?? false) {
      return 'DeliveryDetailInvalid';
    } else {
      final day = ReactiveFormHelper.getControlValue(
        _pickupAppointmentForm!,
        PickupAppointmentFormFields.day.name,
      ) as DateTime;

      final time = ReactiveFormHelper.getControlValue(
        _pickupAppointmentForm!,
        PickupAppointmentFormFields.time.name,
      ) as PickupDropdownValue;

      final weekday = _newDonationData.pickupRange
          .firstWhere((element) => element.id == time.weekdayId);

      final weekdayTime = weekday.ranges
          .firstWhere((element) => element.id == time.rangeTimeId);

      return 'El día ${weekday.weekday} ${DateTimeHelper.formatDateTime(day)} entre las ${weekdayTime.betweenTime}.';
    }
  }

  /// Devuelve true si existe el [Product] en la lista de donacion.
  bool checkIfItemExist(Product product) =>
      _donationItems.checkIfItemExist(product);

  /// Devuelve null si la persona selecciono al menos un item para donar.
  /// Sino devuelve un [NewDonationError]
  NewDonationError? selectedItemsValid() {
    return _donationItems.donationsItemsList.isNotEmpty
        ? null
        : NewDonationError.noProductsSelected;
  }

  /// Devuelve null si la cantidad de los items a donar es valida.
  NewDonationError? itemsQuantityValid() {
    return _donationItems.checkEmptyItems()
        ? NewDonationError.quantityProductsInvalid
        : null;
  }

  /// Devuelve null si el metodo de entrega de la donacion es valido.
  NewDonationError? deliveryValid() {
    if (TypeDelivery.delivery == _deliveryType) {
      return (_deliveryDonation!.valid())
          ? null
          : NewDonationError.pickupRangeInvalid;
    } else {
      return _pickupDonation!.valid()
          ? null
          : NewDonationError.receptionPointInvalid;
    }
  }

  /// Crea una donacion.
  Future<void> createDontaion() async {
    try {
      // if (_newDonation != null) {
      //   await _newDonationApi.createDonation(_newDonation!);
      // }
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _donationItems = DonationItemsDetail();
    _deliveryType = TypeDelivery.pickup;
    _deliveryDonation = null;
    _pickupDonation = null;
    _pickupAppointmentForm = null;
    _newDonationData.resetNewDonationData();
    resetPickupAppointmentForm();
    logSucess('Dispose newDonation');
  }
}
