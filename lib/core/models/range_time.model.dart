class RangeTime {
  final int id;
  final String start;
  final String end;

  RangeTime({
    required this.id,
    required this.end,
    required this.start,
  });

  static RangeTime createOne(Map<String, dynamic> data) {
    return RangeTime(
      id: data['id'],
      end: data['timeClose'],
      start: data['timeOpen'],
    );
  }

  // static RangeTime createOne(Map<String, dynamic> data) {
  //   return RangeTime(
  //     end: data['timeClose'],
  //     start: data['timeOpen'],
  //   );
  // }

  // /// Crea una lista de [ReceptionPoint]
  // static List<RangeTime> createList(List<dynamic> data) {
  //   List<RangeTime> receptionPoints = [];

  //   for (var receptionPoint in data) {
  //     try {
  //       receptionPoints.add(ReceptionPoint.createOne(receptionPoint));
  //     } catch (e) {
  //       logError(e);
  //       rethrow;
  //     }
  //   }

  //   return receptionPoints;
  // }
}
