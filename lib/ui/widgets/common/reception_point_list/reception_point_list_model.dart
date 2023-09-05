import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class ReceptionPointListModel extends BaseViewModel {
  final OnChangeRadioButton onchange;
  final ReceptionPoint? _initialValue;

  ReceptionPointListModel(this.onchange, this._initialValue);

  ReceptionPoint? _selectedValue;
  bool _firstTime = true;

  ReceptionPoint? get selectedValue {
    if (_firstTime) {
      _firstTime = false;
      _selectedValue = _initialValue;
      return _initialValue;
    }

    return _selectedValue;
  }

  void onchangeValue(ReceptionPoint newValue) {
    _selectedValue = newValue;
    onchange(newValue);
    rebuildUi();
  }
}
