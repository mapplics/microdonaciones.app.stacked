import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa los productos que puede recibir una ONG como donacion.
class Product {
  final int id;
  final String name;
  final String urlImg;

  Product({
    required this.id,
    required this.name,
    required this.urlImg,
  })  : assert(
          name.isNotEmpty,
          'The title should not be empty',
        ),
        assert(
          urlImg.isNotEmpty,
          'The pathImg should not be empty',
        );

  /// Crea una instancia de [Product]
  static Product createOne(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      urlImg: data['image'].toString().replaceFirst(
            'http://localhost:8080/',
            'http://10.0.2.2:8080/',
          ),
    );
  }

  /// Crea una lista de [Product]
  static List<Product> createList(List<dynamic> data) {
    List<Product> items = [];

    for (var course in data) {
      try {
        items.add(Product.createOne(course));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return items;
  }
}
