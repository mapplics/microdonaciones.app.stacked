import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:stacked/stacked.dart';

class PageIndicatorModel extends BaseViewModel {
  final DotIndicatorSize size;
  PageIndicatorModel(this.size);

  /// Devuelve true si [index] corresponde a la slide que se esta mostrando.
  bool isCurrentPage(int index, int currentSlide) => (index == currentSlide);

  /// Devuelve el padding que debe haber entre
  /// cada circulo del indicador de pagina.
  EdgeInsetsGeometry getDotPadding(int index, int totalSlides) {
    double _rigthPadding = 0.0;

    if ((index != (totalSlides - 1))) {
      _rigthPadding = DotIndicatorSize.big == size ? 26.0 : 10.0;
    }

    return EdgeInsets.only(right: _rigthPadding);
  }
}
