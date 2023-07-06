import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form.form.dart';
import 'package:stacked/stacked.dart';

class UserInformationFormModel extends FormViewModel {
  /// Setea los campos del formulario con los datos del usuario.
  /// Map11235813
  void initForm(BaseUser user) {
    nameValue = user.name.split(' ')[0];
    surnameValue = user.surname.split(' ')[1];
    phoneValue = user.phoneNumber;

    if (user.runtimeType == LoggedUser) {
      final _loggedUser = user as LoggedUser;
      addressValue = _loggedUser.address;
    }
  }
}
