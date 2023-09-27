import 'package:microdonations/core/models/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';

class PickupWeekDayRangePresentation {
  final String label;

  PickupWeekDayRangePresentation(this.label);

  static PickupWeekDayRangePresentation createOne(
    List<PickupWeekDayRange> options,
    DeliveryNewDonation donation,
  ) {
    final pickupRange = options;
    PickupWeekDayRange _weekDay;
    RangeTime _rangeTime;

    _weekDay = pickupRange
        .firstWhere((weekday) => weekday.weekday.id == donation.weekday);

    _rangeTime = _weekDay.ranges.firstWhere(
      (element) => element.id == donation.rangeId,
    );

    return PickupWeekDayRangePresentation(
      '${_weekDay.weekday} - ${_rangeTime.fullTime}',
    );
  }
}
