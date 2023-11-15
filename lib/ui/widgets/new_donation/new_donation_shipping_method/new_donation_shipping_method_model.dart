import 'package:flutter/material.dart';
import 'package:microdonations/core/parameters/login_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/ong/ong_pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/core/models/user/user_address.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

class DonationShippingMethodModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _newDonationDataService = locator<NewDonationDataService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final scrollController = ScrollController();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  /// Devuelve los puntos de entrega de la ong seleccionada.
  List<OngReceptionPoint> get receptionPoints =>
      _newDonationDataService.receptionPoints;

  /// Devuelve los horarios de retiro de la ong.
  List<OngPickupWeekDayRange> get pickupRange =>
      _newDonationDataService.pickupRange;

  /// Devuelve true si el tipo de delivery [ShippingMethod] seleccionado
  /// es a domicilio.
  bool get isDelivery =>
      _newDonationService.deliveryTypeValue == ShippingMethod.delivery;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged {
    return _authService.isUserLogged;
  }

  /// Devuelve el tipo de entrega que eligio el usuario.
  ShippingMethod get typeDeliverySelected =>
      _newDonationService.deliveryTypeValue;

  /// Devuelve la direccion del usuario.
  UserAddress get userAddress => _authService.loggedUser!.address;

  /// Devuelve el punto de entrega que selecciono el usuario.
  /// Si es que selecciono uno.
  OngReceptionPoint? get receptionPointSelected =>
      _newDonationService.receptionPoint;

  /// Inicializa la direccion del usuario si el tipo es [ShippingMethod.delivery]
  void initUserAddress() {
    if (ShippingMethod.pickup == typeDeliverySelected && isUserLogged) {
      _newDonationService.updateUserAddres(_authService.loggedUser!.address);
    }
  }

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(ShippingMethod type) {
    _newDonationService.updateTypeDelivery(type);

    if (ShippingMethod.delivery == type) {
      resetPickupAppointmentForm();
      _newDonationService.updateReceptionPoint(
        _newDonationDataService.receptionPoints.first,
      );
      _newDonationService.updatePickupAreaConfirm(false);
    } else {
      if (isUserLogged) {
        _newDonationService.updateUserAddres(_authService.loggedUser!.address);
      }
    }

    rebuildUi();
  }

  /// Navega a la pantalla para editar los datos del usuario.
  void navigateToPersonalInformation() {
    _navigationService
        .navigateToPersonalInformationView(
      viewParameters: UserInformationFormParameters(
        user: _authService.loggedUser!,
      ),
    )
        .then((value) {
      /// Siempre que vuelvo de la pagina actualizo la direccion.
      _newDonationService.updateUserAddres(_authService.loggedUser!.address);
    });
  }

  /// Hace un scroll bottom en la pagina.
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  /// Navega a la pantalla de login.
  void navigateToLogin() {
    _navigationService
        .navigateToLoginView(
      viewParameters: LoginViewParameters(
        popWhenFinish: true,
        popUntilFirst: false,
      ),
    )
        .then((value) {
      if (isUserLogged) {
        logSucess('Loguie');
        _newDonationService.updateUserAddres(_authService.loggedUser!.address);
        rebuildUi();
      } else {
        logWarn('no Loguie');
      }
    });
  }

  /// Setea el punto de entrega que eligio el usuario.
  void updateReceptionPoint<ReceptionPoint>(dynamic value) {
    _newDonationService.updateReceptionPoint(value);
  }

  /// Actualiza el formulario para retiro
  void updatePickUpAppointmentForm(FormGroup form) {
    _newDonationService.updatePickUpAppointmentForm(form);

    /// Si todos los datos son validos hago un scroll bottom.
    if (form.valid && areaConfirm) {
      scrollToBottom();
    }

    rebuildUi();
  }

  /// Hace un scroll botom al hacer focus en el campo aclaraciones.
  void onFocusAclaracionesChange(bool hasFocus) {
    if (hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () => scrollToBottom());
    }
  }

  /// Actualiza el valor de area de retiro.
  void toggleAreaConfirm(bool newValue) {
    _newDonationService.updatePickupAreaConfirm(newValue);

    /// Si todos los datos son validos hago un scroll bottom.
    if (areaConfirm && pickupAppointmentFormValid) {
      scrollToBottom();
    }
  }

  /// Devuelve true si el usuario confirmo que esta dentro del area de retiro
  bool get areaConfirm => _newDonationService.pickupAreaConfirmValue;

  /// Devuelve el detalle del delivery.
  /// Muestra el dia, horario y direccion en donde se va a hacer.
  String get deliveryDetail => _newDonationService.pickupTimeDetail;

  /// Resetea el formulario para retiro
  void resetPickupAppointmentForm() {
    _newDonationService.resetPickupAppointmentForm();
  }

  bool get pickupAppointmentFormValid =>
      _newDonationService.pickupAppointmentFormValid;

  /// Devuelve el formulario para retiro.
  FormGroup? get pickupAppointmentForm =>
      _newDonationService.pickupAppointmentForm;
}
