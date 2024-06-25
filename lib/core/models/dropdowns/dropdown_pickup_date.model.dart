import 'package:microdonations/core/abstracts/base_dropdown_item.abstract.dart';
import 'package:microdonations/core/models/ong/ong_pickup_weekday_range.model.dart';

/// Representa una opcion de un Dropdown para elegir un dia de retiro
/// de una donacion a domicilio.
class DropdownPickupDateItem
    implements BaseDropdownItem<OngPickupWeekDayRange> {
  @override
  String label;

  @override
  OngPickupWeekDayRange value;

  DropdownPickupDateItem({
    required this.label,
    required this.value,
  });
}
