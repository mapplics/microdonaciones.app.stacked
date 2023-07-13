import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:stacked/stacked.dart';

class PageIndicatorModel extends BaseViewModel {
  final DotIndicatorSize size;
  PageIndicatorModel(this.size);

  /// Devuelve el espacio que debe haber entre
  /// cada circulo del indicador de pagina.
  get getHorizontalPadding => DotIndicatorSize.big == size ? 26.0 : 10.0;
}
