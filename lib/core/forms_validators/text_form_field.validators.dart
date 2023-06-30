class TextFormFieldValidators {
  static String? notEmpty(String? value) {
    if (value == null) {
      return null;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return 'No esta permitido ingresar numeros en este campo.';
    }

    if (value.isEmpty) {
      return 'Este campo es requerido.';
    }

    return null;
  }
}
