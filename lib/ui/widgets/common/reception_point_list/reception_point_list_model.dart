import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class ReceptionPointListModel extends BaseViewModel {
  final OnChangeRadioButton onchange;
  final OngReceptionPoint? _initialValue;

  ReceptionPointListModel(this.onchange, this._initialValue);

  OngReceptionPoint? _selectedValue;
  bool _firstTime = true;

  OngReceptionPoint? get selectedValue {
    if (_firstTime) {
      _firstTime = false;
      _selectedValue = _initialValue;
      return _initialValue;
    }

    return _selectedValue;
  }

  void onchangeValue(OngReceptionPoint newValue) {
    _selectedValue = newValue;
    onchange(newValue);
    rebuildUi();
  }
}
