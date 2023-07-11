import 'dart:async';

import 'package:microdonations/core/form/validators/only_text.validator.dart';
import 'package:microdonations/core/form/validators/phone_number.validator.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/form/typedef/onchange.typedef.dart';

enum UserInformationFormFields { firstname, lastname, phone, address }

class UserInformationFormModel extends BaseViewModel {
  final OnChangeForm onChange;

  UserInformationFormModel({required this.onChange});

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
        UserInformationFormFields.firstname.name: FormControl<String>(
          value: user.firstname,
          validators: [
            Validators.required,
            const RequiredOnlyText(),
          ],
        ),
        UserInformationFormFields.lastname.name: FormControl<String>(
          value: user.lastname,
          validators: [
            Validators.required,
            const RequiredOnlyText(),
          ],
        ),
        UserInformationFormFields.phone.name: FormControl<String>(
          value: user.phone,
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
        (_) => onChange(_form!),
      ),
    );
  }

  /// Devuelve true si el campo 'address'
  bool _canSetAddres(BaseUser user) => (user.runtimeType == LoggedUser);

  /// Recibe un [BaseUser] y si es de tipo [LoggedUser] devuelve
  /// el contenido del campo address.
  String _tryParceAddress(BaseUser user) {
    final _loggedUser = user as LoggedUser;
    return _loggedUser.address.address;
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
