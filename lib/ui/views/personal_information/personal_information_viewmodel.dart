import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/update_address_request.model.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PersonalInformationViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  late FormGroup _form;

  /// Recibe un [FormGroup] para actualizar el valor de [_form]
  set updateForm(FormGroup newValue) => _form = newValue;

  /// Guarda los datos del usuario.
  Future<void> onSaveUserData(BuildContext context) async {
    if (_form.invalid) {
      logError('Formulario invalido');
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
      await _userService.updateProfile(_updateRequest);
      _navigationService.back();
    } catch (e) {
      logError('Update user failed! ${e.toString()}');
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
