import 'package:microdonations/core/abstracts/base_dropdown_item.abstract.dart';
import 'package:microdonations/core/models/dropdowns/dropdown_pickup_date.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/weekday.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../dropdowns/dropdown_pickup_time.model.dart';

/// Representa un dia de la semana y sus rangos de horarios en donde la ONG
/// puede retirar una donacion a domicilio..
class OngPickupWeekDayRange {
  final Weekday weekday;
  final List<RangeTime> ranges;

  OngPickupWeekDayRange({
    required this.weekday,
    required this.ranges,
  });

  /// Crea una instancia de [OngPickupWeekDayRange]
  static OngPickupWeekDayRange createOne(Map data) {
    return OngPickupWeekDayRange(
      weekday: Weekday.createOne(data),
      ranges: _parseRangeTimes(data['rangeTimes']),
    );
  }

  /// Crea una lista de [OngPickupWeekDayRange]
  static List<OngPickupWeekDayRange> createList(List<dynamic> data) {
    List<OngPickupWeekDayRange> pickupWeekdayRanges = [];

    for (var item in data) {
      try {
        pickupWeekdayRanges.add(OngPickupWeekDayRange.createOne(item));
      } catch (e) {
        logError(e);
        rethrow;
      }
    }

    return pickupWeekdayRanges;
  }

  /// Parse el rango de horarios.
  static List<RangeTime> _parseRangeTimes(List<dynamic> data) {
    List<RangeTime> range = [];

    for (var element in data) {
      range.add(RangeTime.createOne(element));
    }

    return range;
  }

  /// Devuelve una lista de items para seleccionar en un [DropdownButton]
  List<BaseDropdownItem<RangeTime>> getDropdownRanges() {
    List<BaseDropdownItem<RangeTime>> items = [];

    for (var range in ranges) {
      items.add(_prepareRangesForDropdown(range));
    }

    return items;
  }

  /// Convierte la instancia de [OngPickupWeekDayRange] junto con un [range]
  /// en una instancia para usar en un [DropdownButton]
  DropdownPickupTime _prepareRangesForDropdown(RangeTime range) {
    return DropdownPickupTime(
      label: range.fullTime,
      value: range,
    );
  }

  static List<BaseDropdownItem<OngPickupWeekDayRange>> getDropdowns(
      List<OngPickupWeekDayRange> list) {
    final List<BaseDropdownItem<OngPickupWeekDayRange>> dropdowns = [];
    final Set<String> uniqueLabels = {};

    list.forEach((weekday) {
      weekday.ranges.forEach((range) {
        final label = weekday.weekday.name;
        if (!uniqueLabels.contains(label)) {
          dropdowns.add(
            DropdownPickupDateItem(
              label: label,
              value: weekday,
            ),
          );
          uniqueLabels.add(label);
        }
      });
    });

    return dropdowns;
  }
}
