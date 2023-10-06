// ignore_for_file: avoid_init_to_null

import 'package:microdonations/core/enums/new_donation_error.enum.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PickupShippingValidation {
  /// Contiene el formulario con los datos para que retiren la donacion
  /// por el domicilio del donante.
  late FormGroup? _form = null;

  /// Indica si el usuario confirmo que se encuentra dentro del area
  /// de pickup por domicilio.
  late bool _validArea = false;

  /// Actualiza el formulario de pickup a domicilio.
  set updateForm(FormGroup newValue) {
    _form = newValue;
  }

  /// Actualiza el valor de [_validArea].
  set updateValidArea(bool newValue) {
    _validArea = newValue;
  }

  /// Limpia el formulario [_form].
  /// Lo deja en null.
  void clearForm() {
    _form = null;
  }

  /// Devuelve el formulario de pickup.
  FormGroup? get form => _form;

  /// Devuelve el valor de [_validArea].
  bool get validArea => _validArea;

  /// Devuelve true si todos los campos son validos
  /// para que se pueda retirar la donacion a domicilio.
  bool get isValid {
    return ((_form?.valid ?? false) && _validArea);
  }

  /// Devuelve un [NewDonationError] o null si todos los campos son validos.
  NewDonationError? get getTypeError {
    if (_form?.invalid ?? true) {
      return NewDonationError.pickupRangeInvalid;
    } else if (!_validArea) {
      return NewDonationError.pickupAreaInvalid;
    } else {
      return null;
    }
  }
}
