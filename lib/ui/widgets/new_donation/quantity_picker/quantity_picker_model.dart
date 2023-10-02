import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class QuantityPickerModel extends BaseViewModel {
  OnChangeQuantityPicker onChange;
  int initialValue;

  QuantityPickerModel(this.onChange, this.initialValue);

  bool _isFirstLoad = true;

  /// Indica la cantidad seleccionada.
  int _quantity = 0;

  /// Devuelve el valor del checkbox [_checkboxValue]
  int get quantityValue {
    if (_isFirstLoad) {
      _isFirstLoad = false;
      _quantity = initialValue;
      return initialValue;
    } else {
      return _quantity;
    }
  }

  /// Suma uno al [_quantity]
  void addOne() {
    _quantity += 1;
    rebuildUi();
    onChange(_quantity);
  }

  /// Resta uno al [_quantity]
  void substractOne() {
    if (_quantity != 0) {
      _quantity -= 1;
    }
    rebuildUi();
    onChange(_quantity);
  }
}
