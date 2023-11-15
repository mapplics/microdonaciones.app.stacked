import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/new_donation/enums/new_donation_error.enum.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/core/parameters/login_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/common/helpers/focus.helpers.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewDonationViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();

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

  String get slideTitle {
    switch (currentSlide) {
      case 0:
        return '¿Que necesitamos?';
      case 1:
        return 'Cantidad';
      case 2:
        return 'Metodo de entrega';
      case 3:
        return 'Confirmación';
      default:
        return '¿Que necesitamos?';
    }
  }

  /// Funcion que se ejecuta al pasar de slide.
  void onPageChange(int page) {
    currentSlide = page;
    rebuildUi();
  }

  //// Navega a la siguiente pagina.
  void nextPage(BuildContext context) {
    final NewDonationError? validation = _validateCurrentSwipe();

    FocusHelper.closeKeyboard();

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
    FocusHelper.closeKeyboard();

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
            'Para poder continuar, debes seleccionar al menos un producto para donar.';
        break;
      case NewDonationError.quantityProductsInvalid:
        _message =
            'Para poder continuar, todos tus productos deben tener una cantidad mayor a cero.';
        break;
      case NewDonationError.pickupRangeInvalid:
        _message =
            'Para poder continuar, debes elegir un día y horario para que pasemos a retirar tu donación.';
        break;
      case NewDonationError.receptionPointInvalid:
        _message =
            'Para poder continuar, debes elegir un punto de entrega para llevar tu donación.';
        break;
      case NewDonationError.pickupAreaInvalid:
        _message =
            'Para poder continuar, debes confirmar que te encuentras dentro de la zona de retiro.';
        break;
      case NewDonationError.unloggedUser:
        _message =
            'Para poder continuar, necesitamos que inicies sesión. Por favor, ingresa con una cuenta y vuelve a intentarlo.';
        break;
      case NewDonationError.unknow:
        _message =
            'Algo salio mal. Por favor, volve a comenzar tu donacion desde el primer paso.';
        break;
      default:
        _message =
            'Algo salió mal. Por favor, vuelve a comenzar tu donación desde el primer paso.';
    }

    MessegeHelper.showInfoSnackBar(context, _message);
  }

  /// Crea la donacion.
  Future<void> createDonation(BuildContext context) async {
    try {
      FocusHelper.closeKeyboard();

      context.loaderOverlay.show();

      if (!_authService.isUserLogged) {
        _dialogService
            .showCustomDialog(
          title: 'Finalizar donación',
          description:
              'Para poder terminar el proceso de donación necesitamos que inicies sesión. Por favor, crea tu cuenta y volve a intentarlo.',
          variant: DialogType.confirm,
          mainButtonTitle: 'Iniciar sesión',
          secondaryButtonTitle: 'Cancelar',
        )
            .then((value) {
          if (value?.confirmed ?? false) {
            _navigationService.navigateToLoginView(
              viewParameters: LoginViewParameters(
                popWhenFinish: true,
                popUntilFirst: false,
              ),
            );
          }
        });
      } else {
        await _newDonationService.createDontaion();
        _navigationService.replaceWithNewDonationConfirmedView();
      }
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
