import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/dropdowns/pickup_day_dropdown_item.model.dart';
import 'package:microdonations/core/models/dropdowns/pickup_day_dropdown_value.model.dart';
import 'package:microdonations/core/models/dropdowns/time_pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/weekday.model.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import 'dropdowns/time_pickup_dropdown_item.model.dart';

class PickupWeekDayRange {
  final Weekday weekday;
  final List<RangeTime> ranges;

  PickupWeekDayRange({
    required this.weekday,
    required this.ranges,
  });

  /// Crea una instancia de [PickupWeekDayRange]
  static PickupWeekDayRange createOne(Map<String, dynamic> data) {
    return PickupWeekDayRange(
      weekday: Weekday.createOne(data),
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
  List<CustomDropdownItems<TimePickupDropdownValue>> getDropdownRanges() {
    List<CustomDropdownItems<TimePickupDropdownValue>> items = [];

    for (var range in ranges) {
      items.add(_prepareRangesForDropdown(range));
    }

    return items;
  }

  /// Convierte la instancia de [PickupWeekDayRange] junto con un [range]
  /// en una instancia para usar en un [DropdownButton]
  TimePickupDropdownItem _prepareRangesForDropdown(RangeTime range) {
    return TimePickupDropdownItem(
      label: range.fullTime,
      value: TimePickupDropdownValue(rangeTime: range),
    );
  }

  CustomDropdownItems<DatePickupDropdownValue> getDropdownDays() {
    return DatePickupDropdownItem(
      label:
          '${DateTimeHelper.getDayOfWeek(weekday.tag).name.capitalize()} ${weekday.tag.day} de ${DateTimeHelper.getMonthName(weekday.tag)}',
      value: DatePickupDropdownValue(id: weekday.id, date: weekday.tag),
    );
  }
}
