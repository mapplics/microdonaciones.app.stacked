import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';

class PickupWeekDayRangePresentation {
  final String label;

  PickupWeekDayRangePresentation(this.label);

  static PickupWeekDayRangePresentation createOne(
    PickupWeekDayRange _weekDay,
    RangeTime _rangeTime,
  ) {
    return PickupWeekDayRangePresentation(
      '${_weekDay.weekday.name} de ${_rangeTime.fullTime}',
    );
  }
}
