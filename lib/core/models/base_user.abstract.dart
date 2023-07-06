abstract class BaseUser {
  String name;
  String surname;
  String? phoneNumber;
  String? avatarUrl;

  /// Devuelve las iniciales del usuario.
  String getInitials();

  /// Devuelve el nombre completo del usuario.
  String get fullName;

  BaseUser({
    required this.name,
    required this.surname,
    this.phoneNumber = '',
  });
}
