import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.dialogs.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/update_requests/update_address_request.model.dart';
import 'package:microdonations/core/models/update_requests/update_user_request.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart';

class PersonalInformationViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  late FormGroup _form;

  /// Recibe un [FormGroup] para actualizar el valor de [_form]
  set updateForm(FormGroup newValue) => _form = newValue;

  /// Guarda los datos del usuario.
  Future<void> onSaveUserData(BuildContext context) async {
    if (_form.invalid) {
      MessegeHelper.showErrorSnackBar(
        context,
        'El formulario es invalido. Los campos marcados con * son obligatorios.',
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
      MessegeHelper.showSuccessSnackBar(
        context,
        'Tus datos fueron actualizados exitosamente!',
      );
      _navigationService.back();
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        context,
        'No pudimos actualizar tus datos. Por favor, volve a intentarlo.',
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// Desloguea al usuario y navega al login.
  Future<void> logout() async {
    await _authService.logout();
    _navigationService.popRepeated(1);
  }

  deleteAccountConfirm(BuildContext context) {
    _dialogService
        .showCustomDialog(
      title: '¿Eliminamos tu cuenta?',
      description:
          'Eliminaremos tu cuenta y no podras volver a iniciar sesión. Si cambias de opinión deberás comunicarte con nosotros para que volvamos a habilitar tu usuario.',
      variant: DialogType.confirm,
      mainButtonTitle: 'Borrar cuenta',
      secondaryButtonTitle: 'Cancelar',
    )
        .then((value) async {
      if (value?.confirmed ?? false) {
        try {
          context.loaderOverlay.show();
          await Future.delayed(Duration(seconds: 2));
          // await _authService.deleteAccount();
        } catch (e) {
        } finally {
          context.loaderOverlay.hide();
        }
      } else {
        print('cancela');
      }
    });
  }

  bool isApple() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
}
