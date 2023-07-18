import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class DonationItem {
  final String title;
  final String pathImg;

  /// Representa la cantidad que se va a donar del item.
  late int quantity;

  DonationItem({
    required this.title,
    required this.pathImg,
    this.quantity = 0,
  })  : assert(title.isNotEmpty, 'The title should not be empty'),
        assert(!quantity.isNegative, 'The quantity should not be negative'),
        assert(!quantity.isInfinite,
            'The quantity should not be a infinite number'),
        assert(pathImg.isNotEmpty, 'The pathImg should not be empty');

  /// Setea el [quantity] del [DonationItem].
  /// Valida que el numero ingresado no sea negativo.
  set updateQuantity(int value) {
    if (!value.isNegative) {
      quantity = value;
    } else {
      logError('Quantity value invalid!');
    }
  }
}
