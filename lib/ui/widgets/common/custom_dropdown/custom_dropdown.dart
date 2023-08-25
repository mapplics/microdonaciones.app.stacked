import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

import 'custom_dropdown_model.dart';

class CustomDropdownItems<T> {
  final T value;
  final String label;

  CustomDropdownItems({
    required this.label,
    required this.value,
  });
}

class CustomDropdown<T> extends StackedView<CustomDropdownModel> {
  final List<CustomDropdownItems<T>>
      items; // Indicar que los items son de tipo CustomDropdownItems<T>

  const CustomDropdown({required this.items, super.key});

  @override
  Widget builder(
    BuildContext context,
    CustomDropdownModel viewModel,
    Widget? child,
  ) {
    items.map((e) => logWarn(e.label));
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ), // Define el color del borde
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ), // Define el radio del borde
      ),
      child: DropdownButton<T>(
        hint: Text(
          'Seleccioná una opción',
          style: CustomStylesTheme.regular14_20.copyWith(
            color: CustomStylesTheme.lightGreyColor,
          ),
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                child: Text(e.label),
                value: e.value,
              ),
            )
            .toList(),
        value: viewModel.selectedValue,
        iconEnabledColor: CustomStylesTheme.tertiaryColor,
        onChanged: (value) => viewModel.onchangeValue(value),
        dropdownColor: Colors.white,
        menuMaxHeight: 250,
        underline: const SizedBox(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        isExpanded: true,
        style: CustomStylesTheme.regular14_20.copyWith(
          color: CustomStylesTheme.tertiaryColor,
        ),
      ),
    );
  }

  @override
  CustomDropdownModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomDropdownModel();
}
