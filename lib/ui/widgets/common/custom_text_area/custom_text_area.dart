import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_text_area/custom_text_area_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class CustomTextArea extends StackedView<CustomTextAreaModel> {
  final String label;
  final String formControlName;
  final String? hintText;
  final TextInputAction? textInputAction;
  final Map<String, String Function(Object)>? validationMessage;
  final bool isRequired;
  final OnFocusChange? onFocusChange;

  const CustomTextArea({
    required this.label,
    required this.formControlName,
    this.isRequired = false,
    this.hintText,
    this.onFocusChange,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTextAreaModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            if (onFocusChange != null) {
              onFocusChange!(hasFocus);
            }
          },
          child: ReactiveTextField(
            formControlName: formControlName,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.multiline,
            textInputAction: textInputAction,
            validationMessages: validationMessage,
            minLines: 1,
            maxLines: 10,
            maxLength: 500,
            style: AppTheme.regular14_16.copyWith(
              color: AppTheme.blackColor,
            ),
            decoration: AppTheme.inputDecoration(
              label: label,
              required: isRequired,
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  CustomTextAreaModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextAreaModel();
}
