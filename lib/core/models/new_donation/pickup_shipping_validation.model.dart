// ignore_for_file: avoid_init_to_null

import 'package:microdonations/core/models/new_donation/enums/new_donation_error.enum.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Representa los campos requeridos para retirar una donacion a domicilio.
class PickupShippingValidation {
  /// Contiene el formulario con los datos requeridos para el retiro de una donacion.
  late FormGroup? _pickupForm = null;

  /// Indica si el usuario confirmo que se encuentra dentro del area de retiro.
  late bool _validArea = false;

  /// Actualiza el formulario.
  set updateForm(FormGroup newValue) {
    _pickupForm = newValue;
  }

  /// Actualiza el valor de [_validArea].
  set updateValidArea(bool newValue) {
    _validArea = newValue;
  }

  /// Limpia el formulario [_pickupForm].
  void clearForm() {
    _pickupForm = null;
  }

  /// Devuelve el formulario.
  FormGroup? get form => _pickupForm;

  /// Devuelve el valor de [_validArea].
  bool get validArea => _validArea;

  /// Devuelve true si todos los campos son validos
  /// para que se pueda retirar la donacion a domicilio.
  bool get isValid => ((_pickupForm?.valid ?? false) && _validArea);

  /// Devuelve un [NewDonationError] o null si todos los campos son validos.
  NewDonationError? get getTypeError {
    if (_pickupForm?.invalid ?? true) {
      return NewDonationError.pickupRangeInvalid;
    } else if (!_validArea) {
      return NewDonationError.pickupAreaInvalid;
    } else {
      return null;
    }
  }
}
