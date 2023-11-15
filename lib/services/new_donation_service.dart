import 'package:microdonations/core/models/new_donation/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/new_donation/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/new_donation/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:microdonations/core/models/new_donation/donation_product_list.model.dart';
import 'package:microdonations/core/models/new_donation/pickup_new_donation.model.dart';
import 'package:microdonations/core/models/new_donation/pickup_shipping_validation.model.dart';
import 'package:microdonations/core/models/ong/ong_product.model.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/core/models/user/user_address.model.dart';
import 'package:microdonations/core/models/weekday.model.dart';
import 'package:microdonations/services/auth_service.dart';
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
  final _authService = locator<AuthService>();

  late Ong _ongSelected;

  DonationProductList _donationItems = DonationProductList();

  ShippingMethod _shippingMethod = ShippingMethod.pickup;

  DeliveryNewDonation _deliveryDonation = DeliveryNewDonation();

  PickupDonation _pickupDonation = PickupDonation();

  PickupShippingValidation _pickupShippingValidation =
      PickupShippingValidation();

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<DonationProduct> get donationsItems => _donationItems.donationsItemsList;

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

  /// Recibe un [product] que se convierte a [DonationProduct] que se agrega
  /// a la lista de donaciones [_selectedItems].
  void addDonationItem(OngProduct product) {
    final asDonationItem = DonationProduct.createFromProduct(product);
    _donationItems.addDonationItem(asDonationItem);
    notifyListeners();
  }

  /// Recibe un [OngProduct] y busca una coincidencia en [_selectedItems].
  /// Si encuentra una elimina el [DonationProduct] de [_selectedItems]
  void removeDonationItem(OngProduct product) {
    _donationItems.removeDonationItem(product);
    notifyListeners();
  }

  /// Recibe un [DonationProduct] y una cantidad [quantity]
  /// que se le va a asignar al mismo.
  void onChangeItemQuantity(DonationProduct item, int quantity) {
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
  OngReceptionPoint? get receptionPoint => _deliveryDonation.receptionPoint;

  /// Actualiza el punto de entrega de la donacion.
  void updateReceptionPoint(OngReceptionPoint receptionPoint) {
    _deliveryDonation.setReceptionPoint = receptionPoint;
  }

  /// Actualiza el horario de retiro de la donacion por domicilio.
  void _updatePickupTime(RangeTime rangeTime) {
    _pickupDonation.setRangeTime = rangeTime;
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
      final Weekday weekday = ReactiveFormHelper.getControlValue(
        form,
        DeliveryAppointmentFormFields.day.name,
      );

      final RangeTime rangeTime = ReactiveFormHelper.getControlValue(
        form,
        DeliveryAppointmentFormFields.time.name,
      );

      _updatePickupTime(rangeTime);
      _updatePickupDate(weekday.tag);
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

      final Weekday weekday = ReactiveFormHelper.getControlValue(
        form!,
        DeliveryAppointmentFormFields.day.name,
      );

      final RangeTime rangeTime = ReactiveFormHelper.getControlValue(
        form,
        DeliveryAppointmentFormFields.time.name,
      );

      return 'El día ${DateTimeHelper.getDayOfWeek(weekday.tag).name.capitalize()} ${weekday.tag.day} de ${DateTimeHelper.getMonthName(weekday.tag).capitalize()} entre las ${rangeTime.betweenTime}.';
    }
  }

  /// Devuelve true si existe el [OngProduct] en la lista de donacion.
  bool checkIfItemExist(OngProduct product) =>
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
      if (_pickupShippingValidation.isValid) {
        if (!_authService.isUserLogged) {
          return NewDonationError.unloggedUser;
        }

        return null;
      } else {
        return _pickupShippingValidation.getTypeError;
      }
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
    _donationItems = DonationProductList();
    _shippingMethod = ShippingMethod.pickup;
    _deliveryDonation = DeliveryNewDonation();
    _pickupDonation = PickupDonation();
    _pickupShippingValidation = PickupShippingValidation();
    _newDonationData.resetNewDonationData();
    resetPickupAppointmentForm();
  }
}
