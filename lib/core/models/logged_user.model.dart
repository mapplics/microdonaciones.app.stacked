import 'package:microdonations/core/models/firebase_user.model.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';

class LoggedUser implements BaseUser {
  @override
  String firstname;

  @override
  String lastname;

  @override
  String? phone;

  String address;

  @override
  String? avatarUrl;

  LoggedUser({
    required this.firstname,
    required this.lastname,
    required this.address,
    this.phone = '',
    this.avatarUrl = '',
  })  : assert(firstname.isNotEmpty, 'The name should not be empty'),
        assert(lastname.isNotEmpty, 'The surname should not be empty'),
        assert(address.isNotEmpty, 'The address should not be empty');

  /// Crea un usuario a partir de un [LoggedUser] de firebase.
  static LoggedUser createFromFirebaseUser(FirebaseUser user) {
    return LoggedUser(
      firstname: user.firstname,
      lastname: user.lastname,
      avatarUrl: user.avatarUrl ?? '',
      phone: user.phone ?? '',
      address: '',
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
