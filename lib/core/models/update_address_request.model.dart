/// Clase para enviar a la API y actualizar la direccion del usuario
class UpdateAddressRequest {
  final String address;
  final String floor;
  final String apartment;
  final String latitude;
  final String longitude;

  UpdateAddressRequest({
    required this.address,
    required this.floor,
    required this.apartment,
    required this.latitude,
    required this.longitude,
  });

  /// Devuelve el JSON que espera la API cuando se quiere actualizar la
  /// direccion de un usuario.
  /// Este json se envia junto con la clase [UpdateUserRequest]
  Map<String, dynamic> toJson() => {
        'address': address,
        'floor': floor,
        'apartment': apartment,
        'latitude': latitude,
        'longitude': longitude,
      };
}
