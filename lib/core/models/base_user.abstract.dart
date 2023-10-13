abstract class BaseUser {
  String firstname;
  String lastname;
  String? phone;
  String? avatarUrl;

  /// Devuelve las iniciales del usuario.
  String get getInitials;

  /// Devuelve el nombre completo del usuario.
  String get fullName;

  BaseUser({
    required this.firstname,
    required this.lastname,
    this.phone = '',
  });
}
