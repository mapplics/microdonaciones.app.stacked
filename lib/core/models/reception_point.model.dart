import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

/// Representa un punto de entrega de una ONG.
class ReceptionPoint {
  final int id;
  final String name;
  final String address;
  final String extraInfo;

  ReceptionPoint({
    required this.id,
    required this.name,
    required this.address,
    required this.extraInfo,
  });

  /// Recibe un [data] y crea una instancia de un [ReceptionPoint]
  static ReceptionPoint createOne(Map<String, dynamic> data) {
    return ReceptionPoint(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      extraInfo: data['extraInfo'],
    );
  }

  /// Crea una lista de [ReceptionPoint]
  static List<ReceptionPoint> createList(List<dynamic> data) {
    List<ReceptionPoint> receptionPoints = [];

    for (var receptionPoint in data) {
      try {
        receptionPoints.add(ReceptionPoint.createOne(receptionPoint));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return receptionPoints;
  }
}
