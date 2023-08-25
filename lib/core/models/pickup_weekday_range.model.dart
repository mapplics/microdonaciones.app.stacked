import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class PickupWeekDayRange {
  final int id;
  final String weekday;
  final List<RangeTime> range;

  PickupWeekDayRange({
    required this.id,
    required this.weekday,
    required this.range,
  });

  /// Crea una instancia de [PickupWeekDayRange]
  static PickupWeekDayRange createOne(Map<String, dynamic> data) {
    return PickupWeekDayRange(
      id: data['id'],
      weekday: data['name'],
      range: _parseRangeTimes(data['rangeTimes']),
    );
  }

  /// Crea una lista de [PickupWeekDayRange]
  static List<PickupWeekDayRange> createList(List<dynamic> data) {
    List<PickupWeekDayRange> pickupWeekdayRanges = [];

    for (var item in data) {
      try {
        pickupWeekdayRanges.add(PickupWeekDayRange.createOne(item));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return pickupWeekdayRanges;
  }

  /// Parse el rango de horarios de la ong.
  static List<RangeTime> _parseRangeTimes(List<dynamic> data) {
    List<RangeTime> range = [];

    data.forEach((element) {
      range.add(
        RangeTime(
          id: element['id'],
          end: element['timeOpen'],
          start: element['timeClose'],
        ),
      );
    });

    return range;
  }

  List<String> timeByWeek() {
    List<String> timeByWeek = [];
    for (var e in range) {
      timeByWeek.add('$weekday de ${e.fullTime}');
    }

    return timeByWeek;
  }
}
