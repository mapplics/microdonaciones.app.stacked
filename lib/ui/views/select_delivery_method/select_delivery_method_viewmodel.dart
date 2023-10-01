import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectDeliveryMethodViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _newDonationDataService = locator<NewDonationDataService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  /// Devuelve los puntos de entrega de la ong seleccionada.
  List<ReceptionPoint> get receptionPoints =>
      _newDonationDataService.receptionPoints;

  /// Devuelve los horarios de retiro de la ong.
  List<PickupWeekDayRange> get pickupRange =>
      _newDonationDataService.pickupRange;

  /// Devuelve true si el tipo de delivery [ShippingMethod] seleccionado
  /// es a domicilio.
  bool get isDelivery =>
      _newDonationService.deliveryTypeValue == ShippingMethod.delivery;

  /// Devuelve el tipo de entrega que eligio el usuario.
  ShippingMethod get typeDeliverySelected =>
      _newDonationService.deliveryTypeValue;

  /// Devuelve la direccion del usuario.
  UserAddress get userAddress => _userService.loggedUser!.address;

  /// Devuelve la hora y dia que eligio el usuario para que retiren su donacion
  /// si es que eligio una.
  // PickupDropdownValue? get getPickupValue {
  //   return _newDonationService.pickupValue;
  // }

  /// Devuelve el punto de entrega que selecciono el usuario.
  /// Si es que selecciono uno.
  ReceptionPoint? get receptionPointSelected =>
      _newDonationService.receptionPoint;

  /// Inicializa la direccion del usuario si el tipo es [ShippingMethod.delivery]
  void initUserAddress() {
    if (ShippingMethod.pickup == typeDeliverySelected) {
      _newDonationService.updateUserAddres(_userService.loggedUser!.address);
    }
  }

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(ShippingMethod type) {
    _newDonationService.updateTypeDelivery(type);

    logWarn(
      '(selectDeliveryMethodViewModel) onChangeTypeDelivery ${type.name}',
    );

    if (ShippingMethod.delivery == type) {
      logWarn('Reseteo formulario de appointment.');
      resetPickupAppointmentForm();
      _newDonationService.updateReceptionPoint(
        _newDonationDataService.receptionPoints.first,
      );
    } else {
      _newDonationService.updateUserAddres(_userService.loggedUser!.address);
      logWarn('Seteo user address');
    }

    rebuildUi();
  }

  /// Navega a la pantalla para editar los datos del usuario.
  void navigateToPersonalInformation() {
    _navigationService.navigateToPersonalInformationView(
      viewParameters: UserInformationFormParameters(
        user: _userService.loggedUser!,
      ),
    );
  }

  /// Setea el punto de entrega que eligio el usuario.
  void updateReceptionPoint<ReceptionPoint>(dynamic value) {
    logWarn('Actualizo reception point ${value}');
    _newDonationService.updateReceptionPoint(value);
  }

  /// Recibe el formulario para retiro a domicilio
  void updatePickUpAppointmentForm(FormGroup form) {
    _newDonationService.updatePickUpAppointmentForm(form);
    rebuildUi();
  }

  /// Devuelve el detalle del delivery.
  /// Muestra el dia, horario y direccion en donde se va a hacer.
  String get deliveryDetail => _newDonationService.deliveryDetail;

  /// Resetea el formulario para retiro a domicilio
  void resetPickupAppointmentForm() {
    _newDonationService.resetPickupAppointmentForm();
  }

  bool get pickupAppointmentFormValid =>
      _newDonationService.pickupAppointmentFormValid;

  /// Devuelve el formulario para retiro a domicilio
  FormGroup? get pickupAppointmentForm =>
      _newDonationService.pickupAppointmentForm;
}
