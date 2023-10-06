extension StringExtension on String {
  /// Convierte a mayuscula la primer letra.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Convierte a mayuscula la primer letra.
  String removeAccents() {
    final Map<String, String> acentos = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
    };

    String _normalized = this;

    for (final entrada in acentos.entries) {
      _normalized = _normalized.replaceAll(entrada.key, entrada.value);
    }

    return _normalized;
  }

  /// Elimina el exceso de espacios y los remplaza por uno solo.
  String superTrim() {
    final regex = RegExp(r'\s+');
    return replaceAll(regex, ' ');
  }
}
