import 'package:microdonations/core/models/firebase_user.model.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/core/models/user_address.model.dart';

class LoggedUser implements BaseUser {
  @override
  String firstname;

  @override
  String lastname;

  @override
  String? phone;

  @override
  String? avatarUrl;

  UserAddress address;

  LoggedUser({
    required this.firstname,
    required this.lastname,
    required this.address,
    this.phone = '',
    this.avatarUrl = '',
  })  : assert(firstname.isNotEmpty, 'The name should not be empty'),
        assert(lastname.isNotEmpty, 'The surname should not be empty');

  /// Crea una instancia de [LoggedUser] desde un Customer.
  static LoggedUser createOne(Map<String, dynamic> data) {
    return LoggedUser(
      firstname: data['firstname'],
      lastname: data['lastname'],
      phone: data['phone'],
      address: UserAddress(
        address: data['addressPrimary']['address'],
      ),
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
