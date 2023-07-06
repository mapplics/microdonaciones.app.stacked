import 'package:microdonations/core/models/firebase_user.model.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';

class LoggedUser implements BaseUser {
  @override
  String name;

  @override
  String surname;

  @override
  String? phoneNumber;

  String address;

  @override
  String? avatarUrl;

  LoggedUser({
    required this.name,
    required this.surname,
    required this.address,
    this.phoneNumber = '',
    this.avatarUrl = '',
  })  : assert(name.isNotEmpty, 'The name should not be empty'),
        assert(surname.isNotEmpty, 'The surname should not be empty'),
        assert(address.isNotEmpty, 'The address should not be empty');

  /// Crea un usuario a partir de un [LoggedUser] de firebase.
  static LoggedUser createFromFirebaseUser(FirebaseUser user) {
    return LoggedUser(
      name: user.name,
      surname: user.surname,
      avatarUrl: user.avatarUrl ?? '',
      phoneNumber: user.phoneNumber ?? '',
      address: '',
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
