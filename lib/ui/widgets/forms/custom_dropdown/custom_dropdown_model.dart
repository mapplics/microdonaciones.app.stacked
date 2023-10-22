import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/base_dropdown_item.abstract.dart';
import 'package:stacked/stacked.dart';

class CustomDropdownModel<T> extends BaseViewModel {
  List<DropdownMenuItem<T>> getDropdownItems(List<BaseDropdownItem<T>> items) {
    return items
        .map(
          (e) => DropdownMenuItem<T>(
            child: Text(e.label),
            value: e.value,
          ),
        )
        .toList();
  }
}
