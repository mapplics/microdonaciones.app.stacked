import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/weekday.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import 'pickup_dropdown_item.model.dart';

class PickupWeekDayRange {
  final List<RangeTime> ranges;
  final Weekday weekday;

  PickupWeekDayRange({
    required this.weekday,
    required this.ranges,
  });

  /// Crea una instancia de [PickupWeekDayRange]
  static PickupWeekDayRange createOne(Map<String, dynamic> data) {
    return PickupWeekDayRange(
      weekday: Weekday(
        id: data['id'],
        tag: data['tag'],
        name: data['name'],
      ),
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

    for (var element in data) {
      range.add(RangeTime.createOne(element));
    }

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
        weekdayId: weekday.id,
      ),
    );
  }
}
