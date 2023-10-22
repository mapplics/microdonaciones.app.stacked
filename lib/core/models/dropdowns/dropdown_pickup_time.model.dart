import 'package:microdonations/core/abstracts/base_dropdown_item.abstract.dart';
import 'package:microdonations/core/models/range_time.model.dart';

class DropdownPickupTime implements BaseDropdownItem<RangeTime> {
  @override
  String label;

  @override
  RangeTime value;

  DropdownPickupTime({
    required this.label,
    required this.value,
  });
}
