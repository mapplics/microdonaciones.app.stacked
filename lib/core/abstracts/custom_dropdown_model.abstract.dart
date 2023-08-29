abstract class CustomDropdownItems<T> {
  T value;
  String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomDropdownItems<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  CustomDropdownItems({
    required this.label,
    required this.value,
  });
}
