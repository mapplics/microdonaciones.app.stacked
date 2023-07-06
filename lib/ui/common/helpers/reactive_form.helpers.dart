class ReactiveFormHelper {
  /// Devuelve los mensajes de error que se deben mostrar para
  /// los distintos campos de errores.
  static Map<String, String Function(Object)>? get getValidationMessages => {
        'required': (err) => 'Este campo es requerido.',
        'onlyText': (err) =>
            'Este campo solamente puede contener letras. No puede contener numeros ni simbolos.',
        'phoneNumber': (err) =>
            'El numero de telefono no es valido. Debes ingresar un numero con formato 341 o 15',
        'number': (err) =>
            'Este campo solamente puede contener numeros. No puede contener letras ni simbolos.',
      };
}
