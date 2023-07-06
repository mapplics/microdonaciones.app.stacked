import '../models/logged_user.model.dart';

class UserService {
  late LoggedUser _loggedUser;

  void set(LoggedUser user) => _loggedUser = user;

  LoggedUser get loggedUser => _loggedUser;
}
