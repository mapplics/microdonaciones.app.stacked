import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'dot_indicator_model.dart';

class DotIndicator extends StackedView<DotIndicatorModel> {
  final bool active;
  final DotIndicatorSize size;

  const DotIndicator({
    required this.active,
    required this.size,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DotIndicatorModel viewModel,
    Widget? child,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: viewModel.getIndicatorSize,
      width: viewModel.getIndicatorSize,
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
      DotIndicatorModel(size);
}
