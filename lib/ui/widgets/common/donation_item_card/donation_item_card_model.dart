import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class DonationItemCardModel extends BaseViewModel {
  OnChangeCheckbox onchange;

  DonationItemCardModel(this.onchange);

  bool _checkboxValue = false;

  /// Devuelve el valor del checkbox [_checkboxValue]
  bool get checkboxValue => _checkboxValue;

  /// Invierte el valor del checkbox y envia el nuevo valor al padre.
  void toggleCheckbox() {
    _checkboxValue = !_checkboxValue;
    rebuildUi();
    onchange(_checkboxValue);
  }
}
