import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/dropdowns/time_pickup_dropdown_value.model.dart';

class TimePickupDropdownItem
    implements CustomDropdownItems<TimePickupDropdownValue> {
  @override
  String label;

  @override
  TimePickupDropdownValue value;

  TimePickupDropdownItem({
    required this.label,
    required this.value,
  });
}
