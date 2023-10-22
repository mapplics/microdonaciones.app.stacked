abstract class BaseDropdownItem<T> {
  T value;
  String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseDropdownItem<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  BaseDropdownItem({
    required this.label,
    required this.value,
  });
}
