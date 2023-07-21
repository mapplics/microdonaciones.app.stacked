abstract class BaseAddress {
  String address;
  String? floor;
  String? apartment;
  String? latitude;
  String? longitude;

  /// Devuelve la direccion completa del usuario.
  String get fullAddress;

  /// Devuelve true si la persona tiene los campos completos de un
  /// departamento.
  bool get isFlat;

  /// Devuelve el apartamento y el piso, si es que existe.
  String get fullFlat;

  BaseAddress({
    required this.address,
    this.floor = '',
    this.apartment = '',
    this.latitude = '',
    this.longitude = '',
  }) : assert(address.isNotEmpty, 'The address should not be empty');
}
