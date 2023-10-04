import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'dot_indicator_model.dart';

class DotIndicator extends StackedView<DotIndicatorModel> {
  final bool active;
  final int currentSlide;
  final DotIndicatorSize size;
  final bool withPositionsColors;

  const DotIndicator({
    required this.active,
    required this.currentSlide,
    required this.size,
    this.withPositionsColors = false,
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
            ? withPositionsColors
                ? viewModel.getDotColor(currentSlide)
                : CustomStylesTheme.tertiaryColor
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
