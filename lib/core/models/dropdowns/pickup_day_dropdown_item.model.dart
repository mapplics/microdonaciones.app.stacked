import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/dropdowns/pickup_day_dropdown_value.model.dart';

class DatePickupDropdownItem
    implements CustomDropdownItems<DatePickupDropdownValue> {
  @override
  String label;

  @override
  DatePickupDropdownValue value;

  DatePickupDropdownItem({
    required this.label,
    required this.value,
  });
}
