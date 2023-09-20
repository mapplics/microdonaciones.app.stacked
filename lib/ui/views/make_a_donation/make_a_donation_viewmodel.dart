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

class MakeADonationViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_newDonationService];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _haveError = false;

  bool get haveError => _haveError;

  final PageController pageController = PageController(initialPage: 0);
  final int numPages = 4;
  int currentSlide = 0;

  void onPageChange(int page) {
    currentSlide = page;
    rebuildUi();
  }

  /// Devuelve true si se debe mostrar el boton para retroceder una pagina.
  bool get canShowGoBackBtn => currentSlide != 0;

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

  /// Devuelve true si se esta mostrando la ultima slide.
  bool get isLastSlide => ((numPages - 1) == currentSlide);

  Future<void> createDonation(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      await Future.delayed(Duration(seconds: 1));
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
            'Para poder continuar todos tus productos deben tener una cantidad mayor a cero';
        break;
      case NewDonationError.pickupRangeInvalid:
        _message =
            'Para poder continuar debes elegir un dia y horario para que pasemos a retirar tu donación';
        break;
      case NewDonationError.receptionPointInvalid:
        _message =
            'Para poder continuar debes elegir un punto de entrega para llevar tu donación';
        break;
      case NewDonationError.unknow:
        _message =
            'Algo salio mal. Por favor, volve a comenzar tu donacion desde el primer paso';
        break;
      default:
        _message =
            'Algo salio mal. Por favor, volve a comenzar tu donacion desde el primer paso';
    }

    MessegeHelper.showInfoSnackBar(context, _message);
  }

  //// Retrocede una pagina.
  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 175),
      curve: Curves.linear,
    );
  }

  Future<bool> onBackBtnAppbar() async {
    if (currentSlide != 0) {
      previousPage();
      return false;
    } else {
      return true;
    }
  }

  Future<void> initNewDonation() async {
    try {
      _isLoading = true;
      _haveError = false;

      rebuildUi();

      await _newDonationService.initNewDonationData(
        Ong(
          id: 1,
          name: 'ONG',
          web: '',
          mision: '',
          vision: '',
          phone: '',
          email: '',
          enabled: true,
        ),
      );
    } catch (e) {
      _haveError = true;
    } finally {
      _isLoading = false;
      rebuildUi();
    }
  }

  /// Resetea el servicio de [NewDonationService]
  void disposeService() {
    _newDonationService.resetNewDonation();
  }
}
