import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:stacked/stacked.dart';

import 'custom_radio_list_tile_model.dart';

class CustomRadioListTile<T> extends StackedView<CustomRadioListTileModel> {
  final Widget title;
  final Widget? subtitle;
  final T value;
  final T? selectedValue;
  final OnChangeRadioButton onchange;

  const CustomRadioListTile({
    required this.title,
    required this.value,
    required this.onchange,
    this.selectedValue,
    this.subtitle,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomRadioListTileModel viewModel,
    Widget? child,
  ) {
    return RadioListTile<T?>(
      title: title,
      subtitle: subtitle,
      value: value,
      groupValue: selectedValue,
      onChanged: <T>(T value) => onchange(value),
      contentPadding: const EdgeInsets.all(0),
    );
  }

  @override
  CustomRadioListTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomRadioListTileModel();
}
