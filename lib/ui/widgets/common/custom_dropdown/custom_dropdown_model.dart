import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class CustomDropdownModel<T> extends BaseViewModel {
  final OnChangeDropdownButton onchange;

  CustomDropdownModel({required this.onchange});

  late List<DropdownMenuItem<T>> _dropdownItems;

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
    onchange(value);
    rebuildUi();
  }
}
