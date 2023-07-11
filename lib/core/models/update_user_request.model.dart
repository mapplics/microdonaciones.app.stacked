import 'package:microdonations/core/models/update_address_request.model.dart';

class UpdateUserRequest {
  final String firstname;
  final String lastname;
  final String phone;
  final String imageBase54;
  final UpdateAddressRequest address;

  UpdateUserRequest({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.imageBase54,
    required this.address,
  });

  /// Devuelve el JSON que se debe enviar a la API
  /// para actualizar los datos del usuario.
  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "address": address.toJson(),
        "image_base64": imageBase54
      };
}
