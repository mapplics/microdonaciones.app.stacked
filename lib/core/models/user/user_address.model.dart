import 'abstracts/base_address.abstract.dart';

/// Clase para representar la direccion del usuario logueado.
class UserAddress implements BaseAddress {
  final int id;

  @override
  String address;

  @override
  String? floor;

  @override
  String? apartment;

  @override
  String? latitude;

  @override
  String? longitude;

  UserAddress({
    required this.address,
    required this.id,
    this.floor,
    this.apartment,
    this.latitude,
    this.longitude,
  });

  @override
  String get fullAddress => '$address ${isFlat ? fullFlat : ''}';

  @override
  bool get isFlat => apartment != null;

  @override
  String get fullFlat => (floor != null) ? '$apartment - $floor' : '$floor';

  /// Crea una instancia de [UserAddress]
  static UserAddress createOne(Map<String, dynamic> data) {
    return UserAddress(
      id: data['id'],
      address: data['address'],
      apartment: data['apartment'],
      floor: data['floor'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}