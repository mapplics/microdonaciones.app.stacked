import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'terms_and_conditions_checkbox_model.dart';

typedef OnChangeCheckbox = void Function(bool newValue);

class TermsAndConditionsCheckbox
    extends StackedView<TermsAndConditionsCheckboxModel> {
  final OnChangeCheckbox onchange;

  const TermsAndConditionsCheckbox({required this.onchange, super.key});

  @override
  Widget builder(
    BuildContext context,
    TermsAndConditionsCheckboxModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: viewModel.toggleCheckbox,
      child: Row(
        children: [
          Checkbox(
            value: viewModel.checkboxValue,
            onChanged: (_) => viewModel.toggleCheckbox(),
          ),
          Text(
            'Acepto todos los términos y condiciones',
            style: CustomStylesTheme.regular14_24.copyWith(
              color: CustomStylesTheme.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  TermsAndConditionsCheckboxModel viewModelBuilder(
    BuildContext context,
  ) =>
      TermsAndConditionsCheckboxModel(onchange);
}
