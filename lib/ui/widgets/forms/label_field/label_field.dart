import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'label_field_model.dart';

class LabelField extends StackedView<LabelFieldModel> {
  final String label;
  final bool required;

  const LabelField({required this.label, this.required = false, super.key});

  @override
  Widget builder(
    BuildContext context,
    LabelFieldModel viewModel,
    Widget? child,
  ) {
    TextStyle _defaultTextStyle = AppTheme.regular14_20;

    return (required)
        ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: _defaultTextStyle.copyWith(
                    color: AppTheme.blackColor,
                  ),
                ),
                TextSpan(
                  text: ' *',
                  style: _defaultTextStyle.copyWith(
                    color: AppTheme.errorColor,
                  ),
                )
              ],
            ),
          )
        : Text(
            label,
            style: _defaultTextStyle,
            textAlign: TextAlign.center,
          );
  }

  @override
  LabelFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      LabelFieldModel();
}
