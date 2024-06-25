import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un punto de entrega de una ONG.
/// El usuario puede llevar su donacion a este punto de entrega.
class OngReceptionPoint {
  final String id;
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
  static OngReceptionPoint createOne(Map data) {
    return OngReceptionPoint(
      id: data['id'].toString(),
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
        final reception = OngReceptionPoint.createOne(receptionPoint);
        receptionPoints.add(reception);
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return receptionPoints;
  }
}
