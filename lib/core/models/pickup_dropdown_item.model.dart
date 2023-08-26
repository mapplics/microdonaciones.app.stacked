import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';

class PickupDropdownItem implements CustomDropdownItems<PickupDropdownValue> {
  @override
  String label;

  @override
  PickupDropdownValue value;

  PickupDropdownItem({
    required this.label,
    required this.value,
  });
}
