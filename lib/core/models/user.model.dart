import 'package:firebase_auth/firebase_auth.dart' as firebase;

class User {
  final String name;
  final String surname;
  final String photoUrl;
  final String? address;
  final String? phone;

  User({
    required this.name,
    required this.surname,
    required this.phone,
    required this.photoUrl,
    required this.address,
  })  : assert(name.isNotEmpty, 'The name should not be empty'),
        assert(surname.isNotEmpty, 'The surname should not be empty');

  /// Crea un usuario a partir de un [User] de firebase.
  User createFromFirebaseUser(firebase.User user) {
    return User(
      name: user.displayName?.split(" ")[0] ?? 'user',
      surname: user.displayName?.split(" ")[1] ?? 'anonymous',
      photoUrl: user.photoURL ?? '',
      phone: user.phoneNumber ?? '',
      address: '',
    );
  }
}
