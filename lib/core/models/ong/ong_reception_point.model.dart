import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un punto de entrega de una ONG.
/// El usuario puede llevar su donacion a este punto de entrega.
class OngReceptionPoint {
  final int id;
  final String name;
  final String address;
  final String extraInfo;

  OngReceptionPoint({
    required this.id,
    required this.name,
    required this.address,
    required this.extraInfo,
  });

  /// Recibe un [data] y crea una instancia de un [OngReceptionPoint]
  static OngReceptionPoint createOne(Map<String, dynamic> data) {
    return OngReceptionPoint(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      extraInfo: data['extraInfo'],
    );
  }

  /// Crea una lista de [OngReceptionPoint]
  static List<OngReceptionPoint> createList(List<dynamic> data) {
    List<OngReceptionPoint> receptionPoints = [];

    for (var receptionPoint in data) {
      try {
        receptionPoints.add(OngReceptionPoint.createOne(receptionPoint));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return receptionPoints;
  }
}
