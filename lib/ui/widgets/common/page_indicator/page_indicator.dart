import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:stacked/stacked.dart';

import 'page_indicator_model.dart';

class PageIndicator extends StackedView<PageIndicatorModel> {
  final int pageSize;
  final int currentPage;
  final DotIndicatorSize dotIndicatorSize;

  const PageIndicator({
    required this.pageSize,
    required this.currentPage,
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
        for (int i = 0; i < pageSize; i++)
          Padding(
            padding: EdgeInsets.only(
              right:
                  (i != (pageSize - 1)) ? viewModel.getHorizontalPadding : 0.0,
            ),
            child: DotIndicator(
              active: (i == currentPage),
              size: dotIndicatorSize,
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
