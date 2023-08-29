import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class CustomDropdownModel<T> extends BaseViewModel {
  final OnChangeDropdownButton onchange;
  // final List<CustomDropdownItems<T>> items;
  final T? _initialValue;
  bool _firstTime = true;

  CustomDropdownModel({
    required this.onchange,
    // required this.items,
    T? initialValue,
  }) : _initialValue = initialValue;

  late T? _selectedValue = null;
  late List<DropdownMenuItem<T>> _dropdownItems;

  T? get selectedValue {
    if (_firstTime) {
      _firstTime = false;
      _selectedValue = _initialValue;
      // logWarn('Tengo items? ${getDropdownItems.length}');
      logInfo(_initialValue == null
          ? 'No tengo initial value'
          : 'Tengo initial value');

      getDropdownItems.forEach((item) {
        if (item.value == _initialValue) {
          logSucess('Found');
        } else {
          logSucess('nada');
        }
      });

      // return null;
      return null;
    } else {
      return _selectedValue;
    }
  }

  List<DropdownMenuItem<T>> get getDropdownItems => _dropdownItems;

  void loadDropdownItems(List<CustomDropdownItems<T>> items) {
    _dropdownItems = items
        .map(
          (e) => DropdownMenuItem<T>(
            child: Text(e.label),
            value: e.value,
          ),
        )
        .toList();
  }

  void onchangeValue(T? value) {
    _selectedValue = value;
    logSucess('Nuevo valor ${value}');
    onchange(value);
    rebuildUi();
  }
}
