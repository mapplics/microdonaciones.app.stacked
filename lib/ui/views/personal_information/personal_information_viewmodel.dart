import 'package:firebase_auth/firebase_auth.dart';
import 'package:microdonations/ui/views/personal_information/personal_information_view.form.dart';
import 'package:stacked/stacked.dart';

class PersonalInformationViewModel extends FormViewModel {
  /// Setea los campos del formulario con los datos del usuario.
  void initForm(User firebaseUser) {
    nameValue = firebaseUser.displayName?.split(' ')[0] ?? 'User';
    surnameValue = firebaseUser.displayName?.split(' ')[1] ?? 'anonymous';
    phoneValue = firebaseUser.phoneNumber ?? '';
  }
}
