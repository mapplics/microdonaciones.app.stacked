class PickupDropdownValue {
  int weekdayId;
  int rangeTimeId;

  PickupDropdownValue({
    required this.weekdayId,
    required this.rangeTimeId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickupDropdownValue &&
        weekdayId == other.weekdayId &&
        rangeTimeId == other.rangeTimeId;
  }

  @override
  int get hashCode => weekdayId.hashCode ^ rangeTimeId.hashCode;
}
