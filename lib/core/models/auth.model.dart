class AuthModel {
  String token;

  AuthModel({required this.token})
      : assert(token.isNotEmpty, 'The token should not be empty');

  AuthModel.fromJson(Map<String, dynamic> json) : token = json['token'];

  static Map<String, dynamic> toJson(AuthModel value) => {'token': value.token};

  /// Devuelve el token para con el Bearer delante para ser enviado
  /// a la API.
  String get bearer => 'Bearer $token';
}
