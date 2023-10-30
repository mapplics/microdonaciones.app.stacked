import 'package:reactive_forms/reactive_forms.dart';

/// Valida que el campo cumpla el formato de 341 o 15 de un numero de telefono.
class RequiredPhoneNumber extends Validator<dynamic> {
  const RequiredPhoneNumber() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    String value = control.value;
    return (value.length == 12 || value.length == 10)
        ? null
        : {'phoneNumber': true};
  }
}
