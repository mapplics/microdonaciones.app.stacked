import 'package:stacked/stacked.dart';

class QuantityPickerModel extends BaseViewModel {
  /// Indica la cantidad seleccionada.
  int quantity = 0;

  /// Suma uno al [quantity]
  void addOne() {
    quantity += 1;
    rebuildUi();
  }

  /// Resta uno al [quantity]
  void substractOne() {
    if (quantity != 0) {
      quantity -= 1;
    }
    rebuildUi();
  }
}
