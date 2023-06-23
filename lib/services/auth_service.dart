class AuthService {
  /// Indica si el usuario esta logueado o no.
  bool _userLogged = false;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => _userLogged;

  /// Setea el valor de [_userLogged]
  set userLogged(bool newValue) => _userLogged = newValue;
}
