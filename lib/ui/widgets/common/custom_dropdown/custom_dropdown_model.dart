import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

class CustomDropdownModel<T> extends BaseViewModel {
  final OnChangeDropdownButton onchange;

  CustomDropdownModel({required this.onchange});

  List<DropdownMenuItem<T>> getDropdownItems(
      List<CustomDropdownItems<T>> items) {
    return items
        .map(
          (e) => DropdownMenuItem<T>(
            child: Text(e.label),
            value: e.value,
          ),
        )
        .toList();
  }

  void loadDropdownItems(List<CustomDropdownItems<T>> items) {}

  void onchangeValue(T? value) {
    onchange(value);
    rebuildUi();
  }
}
