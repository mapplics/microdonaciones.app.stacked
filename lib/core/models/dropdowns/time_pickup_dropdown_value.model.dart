import 'package:microdonations/core/models/range_time.model.dart';

class TimePickupDropdownValue {
  RangeTime rangeTime;

  TimePickupDropdownValue({required this.rangeTime});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimePickupDropdownValue && rangeTime == other.rangeTime;
  }

  @override
  int get hashCode => rangeTime.hashCode;
}
