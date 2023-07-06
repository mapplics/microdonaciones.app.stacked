import 'package:firebase_auth/firebase_auth.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';

class FirebaseUser implements BaseUser {
  @override
  String name;

  @override
  String surname;

  @override
  String? phoneNumber;

  @override
  String? avatarUrl;

  FirebaseUser({
    required this.name,
    required this.surname,
    this.phoneNumber,
    this.avatarUrl,
  });

  /// Crea una instancia de [FirebaseUser] utilizando
  /// el [User] que devuelve Firebase al hacer un login.
  static FirebaseUser createOne(User user) {
    return FirebaseUser(
      name: user.displayName?.split(" ")[0] ?? 'user',
      surname: user.displayName?.split(" ")[1] ?? 'anonymous',
      avatarUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
    );
  }

  @override
  String get fullName => '$name $surname';

  @override
  String getInitials() {
    List<String> partesNombre = fullName.split(" ");
    String iniciales = "";

    for (var parte in partesNombre) {
      if (parte.isNotEmpty) {
        iniciales += parte[0].toUpperCase();
      }
    }

    return iniciales;
  }
}
