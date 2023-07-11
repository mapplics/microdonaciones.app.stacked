import 'base_address.abstract.dart';

/// Clase para representar la direccion del usuario logueado.
class UserAddress implements BaseAddress {
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
    this.floor,
    this.apartment,
    this.latitude,
    this.longitude,
  });

  /// Crea una instancia de [UserAddress]
  UserAddress createOne(Map<String, dynamic> data) {
    return UserAddress(
      address: data['address'],
      apartment: data['apartment'],
      floor: data['floor'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}
