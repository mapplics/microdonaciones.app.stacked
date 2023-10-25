import 'package:reactive_forms/reactive_forms.dart';

class AddressValidator extends Validator<dynamic> {
  const AddressValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final regex = RegExp(
      r'^(?=.*[A-Za-zÁÉÍÓÚáéíóú])(?=.*\d)(?![\d ])[A-Za-zÁÉÍÓÚáéíóú\d ]+$',
      caseSensitive: false,
    );

    return regex.hasMatch(control.value) ? null : {'address': true};
  }
}
