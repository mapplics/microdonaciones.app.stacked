import 'package:firebase_auth/firebase_auth.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';

class FirebaseUser implements BaseUser {
  @override
  String firstname;

  @override
  String lastname;

  @override
  String? phone;

  @override
  String? avatarUrl;

  FirebaseUser({
    required this.firstname,
    required this.lastname,
    this.phone,
    this.avatarUrl,
  });

  /// Crea una instancia de [FirebaseUser] utilizando
  /// el [User] que devuelve Firebase al hacer un login.
  static FirebaseUser createOne(User user) {
    return FirebaseUser(
      firstname: user.displayName?.split(" ")[0] ?? 'user',
      lastname: user.displayName?.split(" ")[1] ?? 'anonymous',
      avatarUrl: user.photoURL,
      phone: user.phoneNumber,
    );
  }

  @override
  String get fullName => '$firstname $lastname';

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
