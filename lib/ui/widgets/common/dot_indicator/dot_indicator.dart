import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'dot_indicator_model.dart';

class DotIndicator extends StackedView<DotIndicatorModel> {
  final bool active;
  const DotIndicator({required this.active, super.key});

  @override
  Widget builder(
    BuildContext context,
    DotIndicatorModel viewModel,
    Widget? child,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: active
            ? [
                BoxShadow(
                  color: CustomStylesTheme.tertiaryColor.withOpacity(0.3),
                  blurRadius: 7.0,
                )
              ]
            : null,
        color: active
            ? CustomStylesTheme.tertiaryColor
            : CustomStylesTheme.darkGreyColor,
      ),
    );
  }

  @override
  DotIndicatorModel viewModelBuilder(
    BuildContext context,
  ) =>
      DotIndicatorModel();
}
