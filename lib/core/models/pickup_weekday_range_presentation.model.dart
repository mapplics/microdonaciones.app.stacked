import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';

import 'pickup_dropdown_value.model.dart';

class PickupWeekDayRangePresentation {
  final String label;

  PickupWeekDayRangePresentation(this.label);

  static PickupWeekDayRangePresentation createOne(
      List<PickupWeekDayRange> options, PickupDropdownValue pickupValue) {
    final pickupRange = options;
    PickupWeekDayRange _weekDay;
    RangeTime _rangeTime;

    _weekDay = pickupRange
        .firstWhere((weekday) => weekday.id == pickupValue.weekdayId);

    _rangeTime = _weekDay.ranges.firstWhere(
      (element) => element.id == pickupValue.rangeTimeId,
    );

    return PickupWeekDayRangePresentation(
      '${_weekDay.weekday} - ${_rangeTime.fullTime}',
    );
  }
}
