import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'custom_text_field_model.dart';

class CustomInputText extends StackedView<CustomTextFieldModel> {
  final String label;
  final String formControlName;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Map<String, String Function(Object)>? validationMessage;

  const CustomInputText({
    required this.label,
    required this.formControlName,
    this.labelStyle,
    this.valueStyle,
    this.hintText,
    this.validationMessage,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTextFieldModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        ReactiveTextField(
          formControlName: formControlName,
          cursorColor: CustomStylesTheme.primaryColor,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validationMessages: validationMessage,
          style: valueStyle ??
              CustomStylesTheme.regular14_16.copyWith(
                color: CustomStylesTheme.blackColor,
              ),
          decoration: InputDecoration(
            label: Text(
              label,
            ),
            hintText: hintText,
            hintStyle: CustomStylesTheme.bold12_16.copyWith(
              color: CustomStylesTheme.gray100,
            ),
          ),
        ),
      ],
    );
  }

  @override
  CustomTextFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextFieldModel();
}
