import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewDonationViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_newDonationService];
  bool isLoading = false;
  bool haveError = false;

  final PageController pageController = PageController(initialPage: 0);
  final int numPages = 4;
  int currentSlide = 0;

  /// Recupera informacion de la ong que es necesaria para el flujo de donacion
  Future<void> initNewDonation(Ong ongSelected) async {
    try {
      isLoading = true;
      haveError = false;

      rebuildUi();

      await _newDonationService.initNewDonationData(ongSelected);
    } catch (e) {
      haveError = true;
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }

  /// Define la accion del boton de retroceder del appbar.
  Future<bool> onBackBtnAppbar() async {
    if (currentSlide != 0) {
      previousPage();
      return false;
    } else {
      return true;
    }
  }

  /// Devuelve true si se debe mostrar el boton para retroceder una pagina.
  bool get canShowGoBackBtn => currentSlide != 0;

  /// Devuelve true si se esta mostrando la ultima slide.
  bool get isLastSlide => ((numPages - 1) == currentSlide);

  /// Funcion que se ejecuta al pasar de slide.
  void onPageChange(int page) {
    currentSlide = page;
    rebuildUi();
  }

  //// Navega a la siguiente pagina.
  void nextPage(BuildContext context) {
    final NewDonationError? validation = _validateCurrentSwipe();

    if (validation == null) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 175),
        curve: Curves.linear,
      );
    } else {
      _handleSnackError(context, validation);
    }
  }

  //// Retrocede una pagina.
  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 175),
      curve: Curves.linear,
    );
  }

  /// Valida segun el slide actual [currentSlide] si los datos son validos.
  /// devuelve null si es valido.
  /// Sino devuelve un [NewDonationError] con el tipo de error.
  NewDonationError? _validateCurrentSwipe() {
    switch (currentSlide) {
      case 0:
        return _newDonationService.selectedItemsValid();
      case 1:
        return _newDonationService.itemsQuantityValid();
      case 2:
        return _newDonationService.deliveryValid();
      case 3:
        return null;
      default:
        return NewDonationError.unknow;
    }
  }

  /// Muestra un toast de error segun el tipo de error [NewDonationError]
  void _handleSnackError(BuildContext context, NewDonationError error) {
    /// Contendra el mensaje que se mostrara en el toast.
    String _message = '';

    switch (error) {
      case NewDonationError.noProductsSelected:
        _message =
            'Para poder continuar debes seleccionar al menos un producto para donar.';
        break;
      case NewDonationError.quantityProductsInvalid:
        _message =
            'Para poder continuar todos tus productos deben tener una cantidad mayor a cero.';
        break;
      case NewDonationError.pickupRangeInvalid:
        _message =
            'Para poder continuar debes elegir un dia y horario para que pasemos a retirar tu donación.';
        break;
      case NewDonationError.receptionPointInvalid:
        _message =
            'Para poder continuar debes elegir un punto de entrega para llevar tu donación.';
        break;
      case NewDonationError.pickupAreaInvalid:
        _message =
            'Para poder continuar debes confirmar que te encuentras dentro de la zona de retiro.';
        break;
      case NewDonationError.unknow:
        _message =
            'Algo salio mal. Por favor, volve a comenzar tu donacion desde el primer paso.';
        break;
      default:
        _message =
            'Algo salio mal. Por favor, volve a comenzar tu donacion desde el primer paso.';
    }

    MessegeHelper.showInfoSnackBar(context, _message);
  }

  /// Crea la donacion.
  Future<void> createDonation(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      await _newDonationService.createDontaion();
      _navigationService.replaceWithNewDonationConfirmedView();
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        context,
        'No se pudo crear la donacion. Por favor, volve a intentarlo mas tarde.',
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// Resetea el servicio de [NewDonationService]
  void disposeService() {
    _newDonationService.resetNewDonation();
  }
}
