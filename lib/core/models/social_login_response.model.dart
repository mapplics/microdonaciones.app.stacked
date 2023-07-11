import 'package:microdonations/core/models/logged_user.model.dart';

/// Clase que permite tipar la respuesta del endpoint de login de la API.
class SocialLoginResponse {
  int id;
  String email;
  String type;
  String token;
  String tokenType;
  LoggedUser? customer;
  dynamic admin;

  SocialLoginResponse({
    required this.id,
    required this.email,
    required this.type,
    required this.token,
    required this.tokenType,
    this.customer,
    this.admin,
  });

  /// Recibe la respuesta del endpoint social login y devuelve una instancia
  /// de [SocialLoginResponse] que contiene varios datos entre ellos
  /// datos personales del usuario (si es que existen)
  static SocialLoginResponse createOne(Map<String, dynamic> data) {
    return SocialLoginResponse(
      id: data['id'],
      email: data['email'],
      type: data['type'],
      token: data['token'],
      tokenType: data['tokenType'],
      customer: (data['customer'] != null)
          ? LoggedUser.createOne(data['customer'])
          : null,
    );
  }

  /// Devuelve true si el campo [customer] es null.
  bool get customerIsNull => (customer == null);

  /// Devuelve la instancia del usuario logueado. Si es que existe.
  LoggedUser? get loggedUser => customer;
}
