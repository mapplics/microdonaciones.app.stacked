import 'package:reactive_forms/reactive_forms.dart';

/// Valida que el campo cumpla el formato de 341 o 15 de un numero de telefono.
class RequiredOnlyText extends Validator<dynamic> {
  const RequiredOnlyText() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(control.value) ? null : {'onlyText': true};
  }
}
