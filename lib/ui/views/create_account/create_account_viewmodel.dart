import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/core/models/update_requests/update_address_request.model.dart';
import 'package:microdonations/core/models/update_requests/update_user_request.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateAccountViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  /// Es la referencia al formulario del usuario.
  late FormGroup _form;

  /// Indica si el usuario acepto los terminos y condiciones.
  bool _termsAccepted = false;

  /// Recibe un [FormGroup] para actualizar el valor de [_form]
  set updateForm(FormGroup newValue) => _form = newValue;

  /// Actualiza el valor de [_termsAccepted]
  void termsAndConditionsOnChange(bool newValue) => _termsAccepted = newValue;

  /// Guarda los datos del usuario.
  Future<void> onSaveUserData(BuildContext context) async {
    if (_form.invalid) {
      MessegeHelper.showErrorSnackBar(
        context,
        'El formulario es invalido. Los campos marcados con * son obligatorios.',
      );
      return;
    }

    if (!_termsAccepted) {
      MessegeHelper.showErrorSnackBar(
        context,
        'Para poder crear su cuenta debe aceptar los terminos y condiciones.',
      );
      return;
    }

    final _updateRequest = UpdateUserRequest(
      firstname: ReactiveFormHelper.getControlValue(
        _form,
        UserInformationFormFields.firstname.name,
      ),
      lastname: ReactiveFormHelper.getControlValue(
        _form,
        UserInformationFormFields.lastname.name,
      ),
      phone: ReactiveFormHelper.getControlValue(
        _form,
        UserInformationFormFields.phone.name,
      ),
      address: UpdateAddressRequest(
        address: ReactiveFormHelper.getControlValue(
          _form,
          UserInformationFormFields.address.name,
        ),
      ),
      imageBase54: '',
    );

    try {
      context.loaderOverlay.show();
      await _authService.updateProfile(_updateRequest);
      MessegeHelper.showSuccessSnackBar(context, 'Usuario creado con éxito');
      _navigationService.popUntil((route) => route.isFirst);
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        context,
        'No se pudo crear su usuario. Por favor, vuelva a intentarlo',
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
