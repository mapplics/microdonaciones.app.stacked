import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_fill_button/custom_fill_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'empty_state_with_button_model.dart';

class EmptyStateWithButton extends StackedView<EmptyStateWithButtonModel> {
  final String title;
  final String body;
  final String textButton;
  final String? path;
  final Function buttonAction;

  const EmptyStateWithButton({
    Key? key,
    required this.title,
    required this.body,
    required this.textButton,
    required this.buttonAction,
    this.path,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmptyStateWithButtonModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CustomStylesTheme.tertiaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              PhosphorIcons.bold.xCircle,
              color: CustomStylesTheme.errorColor,
              size: 70.0,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: CustomStylesTheme.bold20_24.copyWith(
              color: CustomStylesTheme.blackColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: CustomStylesTheme.regular16_24.copyWith(
              color: CustomStylesTheme.lightGreyColor,
            ),
          ),
          const SizedBox(height: 18),
          CustomFillButton(
            label: textButton,
            action: buttonAction,
            textStyle: CustomStylesTheme.regular16_20.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  EmptyStateWithButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmptyStateWithButtonModel();
}
