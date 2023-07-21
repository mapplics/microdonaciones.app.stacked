import 'package:stacked/stacked.dart';

enum TypeDelivery {
  home,
  branch,
}

class SelectDeliveryMethodViewModel extends BaseViewModel {
  Set<TypeDelivery> _deliveryTypeSelected = <TypeDelivery>{TypeDelivery.home};

  Set<TypeDelivery> get deliveryTypeSelected => _deliveryTypeSelected;

  void onchangeDeliveryType(Set<TypeDelivery> type) {
    _deliveryTypeSelected = type;
    rebuildUi();
  }
}
