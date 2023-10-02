import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class CustomCheckboxModel extends BaseViewModel {
  final OnChangeCheckbox onchange;

  CustomCheckboxModel(this.onchange);

  bool checkboxValue = false;

  /// Invierte el valor del checkbox y envia el nuevo valor al padre.
  void toggleCheckbox() {
    checkboxValue = !checkboxValue;

    rebuildUi();

    /// Envio el nuevo valor al padre.
    onchange(checkboxValue);
  }
}