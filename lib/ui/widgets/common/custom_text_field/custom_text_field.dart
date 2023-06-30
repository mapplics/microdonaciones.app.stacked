import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

import 'custom_text_field_model.dart';

class CustomTextField extends StackedView<CustomTextFieldModel> {
  final String label;
  final TextEditingController? textInputController;
  final String? initialValue;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final String? errorMessage;

  const CustomTextField({
    required this.label,
    this.textInputController,
    this.initialValue,
    this.errorMessage,
    this.labelStyle,
    this.valueStyle,
    this.hintText,
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
        TextFormField(
          controller: textInputController,
          initialValue: initialValue,
          keyboardType: TextInputType.text,
          cursorColor: CustomStylesTheme.primaryColor,
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
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: CustomStylesTheme.bold12_16.copyWith(
              color: CustomStylesTheme.errorColor,
            ),
          )
      ],
    );
  }

  @override
  CustomTextFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextFieldModel();
}
