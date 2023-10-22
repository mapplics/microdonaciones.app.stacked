import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un producto que se le puede donar a una ONG.
class OngProduct {
  final int id;
  final String name;
  final String urlImg;

  OngProduct({
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

  /// Crea una instancia de [OngProduct]
  static OngProduct createOne(Map<String, dynamic> data) {
    return OngProduct(
      id: data['id'],
      name: data['name'],
      urlImg: data['image'].toString().replaceFirst(
            'http://localhost:8080/',
            'http://10.0.2.2:8080/',
          ),
    );
  }

  /// Crea una lista de [OngProduct]
  static List<OngProduct> createList(List<dynamic> data) {
    List<OngProduct> items = [];

    for (var course in data) {
      try {
        items.add(OngProduct.createOne(course));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return items;
  }
}
