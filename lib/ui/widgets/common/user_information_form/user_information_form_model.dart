import 'dart:async';

import 'package:microdonations/core/form/validators/address.validator.dart';
import 'package:microdonations/core/form/validators/only_text.validator.dart';
import 'package:microdonations/core/form/validators/phone_number.validator.dart';
import 'package:microdonations/core/models/user/abstracts/base_user.abstract.dart';
import 'package:microdonations/core/models/user/logged_user.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

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
        UserInformationFormFields.phone.name:
            FormControl<String>(value: user.phone),
        UserInformationFormFields.address.name: FormControl<String>(
          value: _canSetAddres(user) ? _tryParceAddress(user) : '',
          validators: [
            Validators.required,
            const AddressValidator(),
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

    /// Envio al padre el formulario ya inicializado
    /// para que tenga una primera instancia del form.
    onChange(_form!);

    _formSubscriptions.add(
      _form!.valueChanges.listen(
        (_) => onChange(_form!),
      ),
    );
  }

  /// Devuelve true si el campo 'address' existe en el [user]
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
