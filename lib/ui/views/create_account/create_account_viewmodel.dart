import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../../common/helpers/logger.helpers.dart';

class CreateAccountViewModel extends BaseViewModel {
  /// Es la referencia al formulario del usuario.
  late FormGroup _form;

  /// Indica si el usuario acepto los terminos y condiciones.
  bool _termsAccepted = false;

  /// Recibe un [FormGroup] para actualizar el valor de [_form]
  set updateForm(FormGroup newValue) => _form = newValue;

  /// Actualiza el valor de [_termsAccepted]
  void termsAndConditionsOnChange(bool newValue) => _termsAccepted = newValue;

  /// Guarda los datos del usuario.
  void onSaveUserData() {
    if (_form.invalid) {
      logError('Formulario invalido');
      return;
    }

    if (!_termsAccepted) {
      logError('Terminos y condiciones no aceptados');
      return;
    }

    logSucess('Formulario valido');
  }
}
