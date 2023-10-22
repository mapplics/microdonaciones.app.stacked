import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/user/abstracts/base_address.abstract.dart';

/// Clase para enviar a la API y actualizar la direccion del usuario
class UpdateAddressRequest implements BaseAddress {
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

  @override
  String get fullAddress => '$address ${isFlat ? fullFlat : ''}';

  @override
  bool get isFlat => apartment != null;

  @override
  String get fullFlat => (floor != null) ? '$apartment - $floor' : '$floor';

  UpdateAddressRequest({
    required this.address,
    this.floor,
    this.apartment,
    this.latitude,
    this.longitude,
  });

  /// Devuelve el JSON que espera la API cuando se quiere actualizar la
  /// direccion de un usuario.
  /// Este json se envia junto con la clase [UpdateUserRequest]
  Map<String, dynamic> toJson() => {
        'address': address.superTrim(),
        'floor': floor?.superTrim(),
        'apartment': apartment?.superTrim(),
        'latitude': latitude?.superTrim(),
        'longitude': longitude?.superTrim(),
      };
}
