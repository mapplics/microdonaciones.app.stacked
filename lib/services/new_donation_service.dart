import 'package:microdonations/core/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/dropdowns/pickup_day_dropdown_value.model.dart';
import 'package:microdonations/core/models/dropdowns/time_pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/pickup_new_donation.model.dart';
import 'package:microdonations/core/models/pickup_shipping_validation.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/services/new_donation_api_service.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/new_donation/pickup_appointment_form/pickup_appointment_form_model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';

class NewDonationService with ListenableServiceMixin {
  final _newDonationData = locator<NewDonationDataService>();
  final _newDonationApi = locator<NewDonationApiService>();

  late Ong _ongSelected;

  DonationItemsDetail _donationItems = DonationItemsDetail();

  ShippingMethod _shippingMethod = ShippingMethod.pickup;

  DeliveryNewDonation _deliveryDonation = DeliveryNewDonation();

  PickupDonation _pickupDonation = PickupDonation();

  PickupShippingValidation _pickupShippingValidation =
      PickupShippingValidation();

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationItem> get donationsItems => _donationItems.donationsItemsList;

  /// Devuelve las opciones que el usuario puede elegir para donar.
  UserAddress? get userAddres => _pickupDonation.userAddress;

  /// Devuelve la donacion por delivery
  DeliveryNewDonation get deliveryDonation => _deliveryDonation;

  /// Devuelve la donacion por pickup
  PickupDonation get pickupDonation => _pickupDonation;

  /// Devuelve el tipo de delivery que eligio el donante.
  ShippingMethod get deliveryTypeValue => _shippingMethod;

  /// Inicializa el proceso de donacion.
  /// Siempre se debe llamar este metodo antes que cualquier otro.
  Future<void> initNewDonationData(Ong ong) async {
    try {
      /// Seteo la ong para recuperar datos de la misma.
      _newDonationData.setOng = ong;

      _ongSelected = ong;

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

  /// Actualiza el tipo de delivery que se va a usar para la donacion.
  void updateTypeDelivery(ShippingMethod type) {
    _shippingMethod = type;

    if (ShippingMethod.delivery == type) {
      _pickupDonation.resetFields();
    } else {
      _deliveryDonation.resetFields();
    }
  }

  /// Devuelve el punto de entrega, si es que el usuario selecciono uno.
  ReceptionPoint? get receptionPoint => _deliveryDonation.receptionPoint;

  /// Actualiza el punto de entrega de la donacion.
  void updateReceptionPoint(ReceptionPoint receptionPoint) {
    _deliveryDonation.setReceptionPoint = receptionPoint;
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void _updatePickupTime(RangeTime rangeTime) {
    _pickupDonation.setTimeId = rangeTime;
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void _updatePickupObservations(String? obs) {
    _pickupDonation.setObservations = obs ?? '';
  }

  /// Actualiza el dia que se va a retirar la donacion.
  void _updatePickupDate(DateTime date) {
    _pickupDonation.setPickupDate = date;
  }

  /// Actualiza el domicilio del usuario que va a hacer la donacion.
  void updateUserAddres(UserAddress userAddres) {
    _pickupDonation.setUserAddress = userAddres;
  }

  /// Devuelve el formulario de pickup para retiro a domicilio.
  FormGroup? get pickupAppointmentForm => _pickupShippingValidation.form;

  /// Devuelve true si el formulario delivery es valid [_pickupAppointmentForm]
  bool get pickupAppointmentFormValid {
    return _pickupShippingValidation.isValid;
  }

  /// Actualiza el formulario de delivery [_pickupAppointmentForm]
  void updatePickUpAppointmentForm(FormGroup form) {
    if (_pickupShippingValidation.form?.valid ?? false) {
      final dropdownDayValue = ReactiveFormHelper.getControlValue(
              form, DeliveryAppointmentFormFields.day.name)
          as DatePickupDropdownValue;

      final dropdownRangeValue = ReactiveFormHelper.getControlValue(
              form, DeliveryAppointmentFormFields.time.name)
          as TimePickupDropdownValue;

      _updatePickupTime(dropdownRangeValue.rangeTime);
      _updatePickupDate(dropdownDayValue.date);
    }

    final obs = ReactiveFormHelper.getControlValue(
        form, DeliveryAppointmentFormFields.observations.name);

    _updatePickupObservations(obs);

    _pickupShippingValidation.updateForm = form;
  }

  void updatePickupAreaConfirm(bool newValue) {
    _pickupShippingValidation.updateValidArea = newValue;
  }

  /// Devuelve true si el usuario confirmo que esta dentro del area de retiro.
  bool get pickupAreaConfirmValue {
    return _pickupShippingValidation.validArea;
  }

  /// Limpia el formulario de pickup de [_pickupShippingValidation]
  void resetPickupAppointmentForm() {
    _pickupShippingValidation.clearForm();
  }

  ///
  String get pickupTimeDetail {
    if (_pickupShippingValidation.form?.invalid ?? false) {
      return 'DeliveryDetailInvalid';
    } else {
      final form = _pickupShippingValidation.form;

      final day = ReactiveFormHelper.getControlValue(
              form!, DeliveryAppointmentFormFields.day.name)
          as DatePickupDropdownValue;

      final time = ReactiveFormHelper.getControlValue(
              form, DeliveryAppointmentFormFields.time.name)
          as TimePickupDropdownValue;

      return 'El día ${DateTimeHelper.getDayOfWeek(day.date).name.capitalize()} ${day.date.day} de ${DateTimeHelper.getMonthName(day.date).capitalize()} entre las ${time.rangeTime.betweenTime}.';
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
    if (ShippingMethod.delivery == _shippingMethod) {
      return (_deliveryDonation.valid())
          ? null
          : NewDonationError.receptionPointInvalid;
    } else {
      return _pickupShippingValidation.isValid
          ? null
          : _pickupShippingValidation.getTypeError;
    }
  }

  /// Crea una donacion.
  Future<void> createDontaion() async {
    try {
      BaseNewDonation donation = (ShippingMethod.delivery == _shippingMethod)
          ? _deliveryDonation
          : _pickupDonation;

      donation.setOng = _ongSelected;
      donation.setDonationItemsDetail = _donationItems;

      await _newDonationApi.createDonation(donation);
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonation() {
    _donationItems = DonationItemsDetail();
    _shippingMethod = ShippingMethod.pickup;
    _deliveryDonation = DeliveryNewDonation();
    _pickupDonation = PickupDonation();
    _pickupShippingValidation = PickupShippingValidation();
    _newDonationData.resetNewDonationData();
    resetPickupAppointmentForm();
  }
}
