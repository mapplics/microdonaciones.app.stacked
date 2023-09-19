import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import 'pickup_dropdown_item.model.dart';

class PickupWeekDayRange {
  final int id;
  final String weekday;
  final List<RangeTime> ranges;

  PickupWeekDayRange({
    required this.id,
    required this.weekday,
    required this.ranges,
  });

  /// Crea una instancia de [PickupWeekDayRange]
  static PickupWeekDayRange createOne(Map<String, dynamic> data) {
    return PickupWeekDayRange(
      id: data['id'],
      weekday: data['name'],
      ranges: _parseRangeTimes(data['rangeTimes']),
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
          end: element['timeClose'],
          start: element['timeOpen'],
        ),
      );
    });

    return range;
  }

  /// Devuelve una lista de items para seleccionar en un [DropdownButton]
  List<CustomDropdownItems<PickupDropdownValue>> prepareForDropdown() {
    List<CustomDropdownItems<PickupDropdownValue>> items = [];

    for (var range in ranges) {
      items.add(_getPickupDropdownItem(range));
    }

    return items;
  }

  /// Convierte la instancia de [PickupWeekDayRange] junto con un [range]
  /// en una instancia para usar en un [DropdownButton]
  PickupDropdownItem _getPickupDropdownItem(RangeTime range) {
    return PickupDropdownItem(
      label: range.fullTime,
      value: PickupDropdownValue(
        rangeTimeId: range.id,
        weekdayId: id,
      ),
    );
  }
}
