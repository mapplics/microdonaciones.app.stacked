import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

enum DotIndicatorSize {
  small,
  big,
}

class DotIndicatorModel extends BaseViewModel {
  final DotIndicatorSize indicatorSize;

  DotIndicatorModel(this.indicatorSize);

  /// Devuelve el tamaño que debe tener el dot.
  double get getIndicatorSize =>
      (indicatorSize == DotIndicatorSize.small) ? 9.0 : 12.0;

  /// Devuelve el color que debe tener el dot.
  Color getDotColor(int currentSlide) {
    switch (currentSlide) {
      case 0:
        return CustomStylesTheme.tertiaryColor;
      case 1:
        return CustomStylesTheme.secondaryColor;
      case 2:
        return CustomStylesTheme.primaryColor;
      default:
        return CustomStylesTheme.tertiaryColor;
    }
  }
}
