import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormHelper {
  /// Devuelve true si el campo es requerido.
  /// Devuelve true si el [fieldName] para el [form] pasados por argumentos es requerido.
  static bool isRequiredField(FormGroup form, String fieldName) =>
      form.control(fieldName).validators.isNotEmpty;

  /// Devuelve el valor que tenga el control [fieldName] en el [form].
  static dynamic getControlValue(FormGroup form, String fieldName) {
    return form.control(fieldName).value;
  }

  /// Devuelve los mensajes de error que se deben mostrar para
  /// los distintos campos de errores.
  static Map<String, String Function(Object)>? get getValidationMessages => {
        'required': (err) => 'Este campo es requerido.',
        'onlyText': (err) =>
            'Este campo solamente puede contener letras. No puede contener numeros ni simbolos.',
        'phoneNumber': (err) =>
            'El numero de telefono no es valido. Debe tener 10 o 12 caracteres de longitud.',
        'number': (err) =>
            'Este campo solamente puede contener numeros. No puede contener letras ni simbolos.',
        'address': (err) =>
            'La dirección es invalida. Recuerda que debes incluir nombre de la calle y numero.',
      };
}
