import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/label_field/label_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'weekday_picker_model.dart';

typedef OnChangeDateTime = void Function(DateTime value);

class WeekdayPicker extends StackedView<WeekdayPickerModel> {
  final String label;
  final String formControlName;
  final DateTime? initialDate;
  final String? hintText;
  final bool required;
  final OnChangeWeekdayPicker onchange;
  final Map<String, String Function(Object)>? validationMessage;

  const WeekdayPicker({
    required this.label,
    required this.formControlName,
    required this.validationMessage,
    required this.initialDate,
    required this.onchange,
    required this.required,
    this.hintText,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    WeekdayPickerModel viewModel,
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
        ReactiveTextField(
          onTap: (_) => viewModel.openDatePicker(context),
          style: CustomStylesTheme.regular16_24.copyWith(
            color: CustomStylesTheme.blackColor,
          ),
          formControlName: formControlName,
          controller: viewModel.controller,
          validationMessages: validationMessage,
          decoration: CustomStylesTheme.inputDecoration('', hintText: hintText),
          readOnly: true,
        ),
      ],
    );
  }

  @override
  WeekdayPickerModel viewModelBuilder(
    BuildContext context,
  ) =>
      WeekdayPickerModel(onchange);
}
