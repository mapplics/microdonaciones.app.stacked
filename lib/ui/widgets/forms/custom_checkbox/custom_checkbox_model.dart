import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class CustomCheckboxModel extends BaseViewModel {
  final OnChangeCheckbox onchange;
  final bool initialValue;

  CustomCheckboxModel(this.onchange, this.initialValue);

  bool checkboxValue = false;
  bool _firstTime = true;

  bool get selectedValue {
    if (_firstTime) {
      _firstTime = false;
      checkboxValue = initialValue;
      return checkboxValue;
    } else {
      return checkboxValue;
    }
  }

  /// Invierte el valor del checkbox y envia el nuevo valor al padre.
  void toggleCheckbox() {
    checkboxValue = !checkboxValue;

    rebuildUi();

    /// Envio el nuevo valor al padre.
    onchange(checkboxValue);
  }
}
