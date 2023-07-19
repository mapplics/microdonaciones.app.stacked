import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un item/tipo [Product] que eligio un usuario para donar
/// junto con la cantidad del mismo.
class DonationItem {
  Product product;

  /// Representa la cantidad que se va a donar del item.
  int quantity;

  DonationItem({
    required this.product,
    this.quantity = 0,
  })  : assert(
          !quantity.isNegative,
          'The quantity should not be negative',
        ),
        assert(
          !quantity.isInfinite,
          'The quantity should not be a infinite number',
        );

  /// Crea un [DonationItem] usando un [Product] como referencia.
  static DonationItem createFromProduct(Product product) {
    return DonationItem(product: product, quantity: 0);
  }

  /// Devuelve el titulo del producto a donar.
  String get title => product.text;

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
