import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/terms_and_conditions_checkbox/terms_and_conditions_checkbox.dart';
import 'package:stacked/stacked.dart';

class TermsAndConditionsCheckboxModel extends BaseViewModel {
  final OnChangeCheckbox onchange;

  TermsAndConditionsCheckboxModel(this.onchange);

  bool _checkboxValue = false;

  /// Devuelve el valor del checkbox [_checkboxValue]
  bool get checkboxValue => _checkboxValue;

  /// Invierte el valor del checkbox y envia el nuevo valor al padre.
  void toggleCheckbox() {
    _checkboxValue = !_checkboxValue;

    rebuildUi();

    /// Envio el nuevo valor al padre.
    logWarn('envio $_checkboxValue');
    onchange(_checkboxValue);
  }
}
