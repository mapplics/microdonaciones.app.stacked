import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../../common/helpers/logger.helpers.dart';

class CreateAccountViewModel extends BaseViewModel {
  late FormGroup _form;

  /// Recibe un [FormGroup] para actualizar el valor de [_form]
  set updateForm(FormGroup newValue) => _form = newValue;

  /// Guarda los datos del usuario.
  void onSaveUserData() {
    if (_form.invalid) {
      logError('Formulario invalido');
      return;
    }
    logSucess('Formulario valido');
  }
}
