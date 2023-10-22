import 'package:microdonations/core/abstracts/base_dropdown_item.abstract.dart';
import 'package:microdonations/core/models/weekday.model.dart';

/// Representa una opcion de un Dropdown para elegir un dia de retiro
/// de una donacion a domicilio.
class DropdownPickupDateItem implements BaseDropdownItem<Weekday> {
  @override
  String label;

  @override
  Weekday value;

  DropdownPickupDateItem({
    required this.label,
    required this.value,
  });
}
