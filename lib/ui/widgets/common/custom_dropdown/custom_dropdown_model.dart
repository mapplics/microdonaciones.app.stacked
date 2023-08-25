import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class CustomDropdownModel<T> extends BaseViewModel {
  late T? _selectedValue = null;

  T? get selectedValue => _selectedValue;

  void onchangeValue(T? value) {
    _selectedValue = value;
    logSucess('Nuevo valor ${value}');
    rebuildUi();
  }
}
