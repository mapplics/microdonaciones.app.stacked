class DatePickupDropdownValue {
  int id;
  DateTime date;

  DatePickupDropdownValue({required this.id, required this.date});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DatePickupDropdownValue && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
