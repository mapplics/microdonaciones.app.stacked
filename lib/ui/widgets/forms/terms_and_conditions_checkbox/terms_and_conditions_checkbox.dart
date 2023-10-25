import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/helpers/launcher_url.helpers.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:microdonations/ui/widgets/forms/custom_checkbox/custom_checkbox.dart';
import 'package:microdonations/ui/widgets/forms/terms_and_conditions_checkbox/terms_and_conditions_checkbox_model.dart';
import 'package:stacked/stacked.dart';

class TermsAndConditionsCheckbox
    extends StackedView<TermsAndConditionsCheckboxModel> {
  final OnChangeCheckbox onchange;

  const TermsAndConditionsCheckbox({
    required this.onchange,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    TermsAndConditionsCheckboxModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        LinkButton(
          label: 'Ver terminos y condiciones',
          action: () {
            LaunchUrlHelper.openUrl(
              'https://codigofuente.ar/tyc-microdonaciones/',
            );
          },
        ),
        SizedBox(
          height: 30,
          child: CustomCheckbox(
            label: 'Acepto todos los términos y condiciones',
            onchange: (newValue) => onchange(newValue),
          ),
        ),
      ],
    );
  }

  @override
  TermsAndConditionsCheckboxModel viewModelBuilder(
    BuildContext context,
  ) =>
      TermsAndConditionsCheckboxModel();
}
