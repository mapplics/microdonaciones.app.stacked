import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:stacked/stacked.dart';

import 'page_indicator_model.dart';

class PageIndicator extends StackedView<PageIndicatorModel> {
  final int totalSlides;
  final int currentSlide;
  final DotIndicatorSize dotIndicatorSize;
  final bool withPositionsColors;

  const PageIndicator({
    required this.totalSlides,
    required this.currentSlide,
    this.withPositionsColors = false,
    this.dotIndicatorSize = DotIndicatorSize.big,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    PageIndicatorModel viewModel,
    Widget? child,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < totalSlides; index++)
          Padding(
            padding: viewModel.getDotPadding(index, totalSlides),
            child: DotIndicator(
              active: viewModel.isCurrentPage(index, currentSlide),
              size: dotIndicatorSize,
              currentSlide: currentSlide,
              withPositionsColors: withPositionsColors,
            ),
          )
      ],
    );
  }

  @override
  PageIndicatorModel viewModelBuilder(
    BuildContext context,
  ) =>
      PageIndicatorModel(dotIndicatorSize);
}
