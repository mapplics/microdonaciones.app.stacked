import 'dart:async';

import 'package:microdonations/core/forms_validators/only_text.validator.dart';
import 'package:microdonations/core/forms_validators/phone_number.validator.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

enum UserInformationFormFields { name, surname, phone, address }

class UserInformationFormModel extends BaseViewModel {
  final OnChangeValue action;

  UserInformationFormModel({required this.action});

  FormGroup? _form;

  final List<StreamSubscription<dynamic>> _formSubscriptions = [];

  /// Devuelve el formulario del usuario.
  FormGroup? get formGroup => _form;

  /// Devuelve true si el formulario fue initializado.
  bool get isFormInitialized => (formGroup != null);

  /// Setea los campos del formulario con los datos del user.
  void initForm(BaseUser user) {
    _form = FormGroup(
      {
        UserInformationFormFields.name.name: FormControl<String>(
          value: user.name,
          validators: [
            Validators.required,
            const RequiredOnlyText(),
          ],
        ),
        UserInformationFormFields.surname.name: FormControl<String>(
          value: user.surname,
          validators: [
            Validators.required,
            const RequiredOnlyText(),
          ],
        ),
        UserInformationFormFields.phone.name: FormControl<String>(
          value: user.phoneNumber,
        ),
        UserInformationFormFields.address.name: FormControl<String>(
          value: _canSetAddres(user) ? _tryParceAddress(user) : '',
          validators: [
            Validators.required,
          ],
        ),
      },
    );

    final _phoneControl = _form!.control(UserInformationFormFields.phone.name);

    _formSubscriptions.add(
      _phoneControl.valueChanges.listen(
        (_) {
          final stringValue = _phoneControl.value as String;

          if (stringValue.isEmpty) {
            _phoneControl.clearValidators();
          } else {
            _phoneControl.setValidators(
              [
                Validators.number,
                const RequiredPhoneNumber(),
              ],
            );
          }

          _phoneControl.updateValueAndValidity(
            updateParent: false,
            emitEvent: false,
          );
        },
      ),
    );

    _formSubscriptions.add(
      _form!.valueChanges.listen(
        (_) => action(_form!),
      ),
    );
  }

  /// Devuelve true si el campo 'address'
  bool _canSetAddres(BaseUser user) => (user.runtimeType == LoggedUser);

  /// Recibe un [BaseUser] y si es de tipo [LoggedUser] devuelve
  /// el contenido del campo address.
  String _tryParceAddress(BaseUser user) {
    final _loggedUser = user as LoggedUser;
    return _loggedUser.address;
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
