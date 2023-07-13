import 'package:stacked/stacked.dart';

enum DotIndicatorSize {
  small,
  big,
}

class DotIndicatorModel extends BaseViewModel {
  final DotIndicatorSize indicatorSize;

  DotIndicatorModel(this.indicatorSize);

  double get getIndicatorSize =>
      (indicatorSize == DotIndicatorSize.small) ? 9.0 : 12.0;
}
