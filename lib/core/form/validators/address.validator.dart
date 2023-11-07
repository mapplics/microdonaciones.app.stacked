import 'package:reactive_forms/reactive_forms.dart';

class AddressValidator extends Validator<dynamic> {
  const AddressValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final regex = RegExp(
      r'^(?=.*[A-Za-zñÑáéíóúÁÉÍÓÚ].*[0-9]|[0-9].*[A-Za-zñÑáéíóúÁÉÍÓÚ]).+$',
      caseSensitive: false,
    );

    return regex.hasMatch(control.value) ? null : {'address': true};
  }
}
