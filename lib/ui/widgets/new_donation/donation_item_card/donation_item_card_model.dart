import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class DonationItemCardModel extends BaseViewModel {
  OnChangeCheckbox onchange;
  bool initialValue;

  DonationItemCardModel(this.onchange, this.initialValue);

  bool _checkboxValue = false;
  bool _isFirstLoad = true;

  /// Devuelve el valor del checkbox [_checkboxValue]
  bool get checkboxValue {
    if (_isFirstLoad) {
      _isFirstLoad = false;
      _checkboxValue = initialValue;
      return initialValue;
    } else {
      return _checkboxValue;
    }
  }

  /// Invierte el valor del checkbox y envia el nuevo valor al padre.
  void toggleCheckbox() {
    _checkboxValue = !_checkboxValue;
    onchange(_checkboxValue);
    rebuildUi();
  }
}
