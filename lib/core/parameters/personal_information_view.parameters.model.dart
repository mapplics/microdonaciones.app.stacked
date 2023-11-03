import 'package:microdonations/core/models/user/logged_user.model.dart';

class UserInformationFormParameters {
  final LoggedUser user;
  final bool userLogged;

  UserInformationFormParameters({
    required this.user,
    this.userLogged = false,
  });
}
