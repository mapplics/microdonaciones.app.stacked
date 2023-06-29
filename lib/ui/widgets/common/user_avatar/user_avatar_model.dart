import 'package:stacked/stacked.dart';

class UserAvatarModel extends BaseViewModel {
  /// Devuelve las iniciales para poder setearlas en el campo [initials]
  String getInitials(String fullName) {
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
