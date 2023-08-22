import 'package:microdonations/core/models/logged_user.model.dart';

class UserInformationFormParameters {
  final LoggedUser user;
  final bool showLogoutButton;

  UserInformationFormParameters({
    required this.user,
    this.showLogoutButton = false,
  });
}
