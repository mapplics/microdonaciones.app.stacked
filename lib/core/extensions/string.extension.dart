extension StringExtension on String {
  /// Convierte a mayuscula la primer letra.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
