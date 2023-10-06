import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'custom_checkbox_model.dart';

class CustomCheckbox extends StackedView<CustomCheckboxModel> {
  final String label;
  final OnChangeCheckbox onchange;
  final Widget? content;

  const CustomCheckbox({
    required this.onchange,
    required this.label,
    this.content,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomCheckboxModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: viewModel.toggleCheckbox,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Checkbox(
              value: viewModel.checkboxValue,
              onChanged: (_) => viewModel.toggleCheckbox(),
            ),
          ),
          content ??
              Text(
                label,
                style: CustomStylesTheme.regular14_24.copyWith(
                  color: CustomStylesTheme.blackColor,
                ),
              ),
        ],
      ),
    );
  }

  @override
  CustomCheckboxModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomCheckboxModel(onchange);
}
