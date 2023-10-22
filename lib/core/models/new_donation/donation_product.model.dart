import 'package:microdonations/core/models/ong/ong_product.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un producto que el usuario eligio para donar
/// junto con la cantidad del mismo.
class DonationProduct {
  OngProduct product;
  int quantity;

  DonationProduct({
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

  /// Crea un [DonationProduct] usando un [OngProduct] como referencia.
  static DonationProduct createFromProduct(OngProduct product) {
    return DonationProduct(product: product, quantity: 0);
  }

  /// Crea la instancia de un [DonationProduct] en base a una respuesta de la API.
  static DonationProduct createOne(Map<String, dynamic> data) {
    return DonationProduct(
      product: OngProduct(
        id: data['id'],
        name: data['name'],
        urlImg: data['image'],
      ),
      quantity: data['quantity'] ?? 0,
    );
  }

  /// Crea un arreglo de [DonationProduct] en base a una respuesta de la API.
  static List<DonationProduct> createArray(List<dynamic> data) {
    final List<DonationProduct> items = [];

    for (var item in data) {
      try {
        items.add(
          DonationProduct.createOne(item),
        );
      } catch (e) {
        continue;
      }
    }

    return items;
  }

  /// Devuelve el titulo del producto a donar.
  String get title => product.name;

  /// Setea el [quantity] del [DonationProduct].
  set updateQuantity(int value) {
    if (!value.isNegative) {
      quantity = value;
    } else {
      logError('Quantity value invalid!');
    }
  }
}
