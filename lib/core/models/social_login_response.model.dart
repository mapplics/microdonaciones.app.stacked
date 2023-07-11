import 'package:microdonations/core/models/base_user.abstract.dart';

class SocialLoginResponse {
  int id;
  String email;
  String type;
  String token;
  String tokenType;
  BaseUser? customer;
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

  static SocialLoginResponse createOne(Map<String, dynamic> data) {
    return SocialLoginResponse(
      id: data['id'],
      email: data['email'],
      type: data['type'],
      token: data['token'],
      tokenType: data['tokenType'],
      customer: data['customer'],
    );
  }

  /// Devuelve true si el campo [customer] es null.
  bool get customerIsNull => (customer == null);
}
