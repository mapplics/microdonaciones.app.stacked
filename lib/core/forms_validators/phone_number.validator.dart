import 'package:reactive_forms/reactive_forms.dart';

/// Valida que el campo cumpla el formato de 341 o 15 de un numero de telefono.
class RequiredPhoneNumber extends Validator<dynamic> {
  const RequiredPhoneNumber() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    RegExp regex = RegExp(r'^(341|15)\d{7}$');
    return regex.hasMatch(control.value) ? null : {'phoneNumber': true};
  }
}
