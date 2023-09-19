import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/label_field/label_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'custom_dropdown_model.dart';

class CustomDropdown<T> extends StackedView<CustomDropdownModel> {
  final OnChangeDropdownButton onchange;
  final List<CustomDropdownItems<T>> items;
  final String formControlName;
  final String label;
  final bool required;

  const CustomDropdown({
    required this.items,
    required this.onchange,
    required this.formControlName,
    required this.required,
    required this.label,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomDropdownModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(
          label: label,
          required: required,
        ),
        const SizedBox(
          height: 8,
        ),
        ReactiveDropdownField<T>(
          formControlName: formControlName,
          decoration: CustomStylesTheme.inputDecoration(hintText: ''),
          iconEnabledColor: CustomStylesTheme.tertiaryColor,
          items: viewModel.getDropdownItems(items) as List<DropdownMenuItem<T>>,
          isExpanded: true,
          dropdownColor: Colors.white,
          menuMaxHeight: 375,
          validationMessages: ReactiveFormHelper.getValidationMessages,
          hint: Text(
            'Seleccioná una opción',
            style: CustomStylesTheme.regular14_24.copyWith(
              color: CustomStylesTheme.gray300,
            ),
          ),
          style: CustomStylesTheme.regular14_20.copyWith(
            color: CustomStylesTheme.tertiaryColor,
          ),
        )
      ],
    );
  }

  @override
  CustomDropdownModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomDropdownModel<T>(
        onchange: onchange,
        // initialValue: initialValue,
      );
}
