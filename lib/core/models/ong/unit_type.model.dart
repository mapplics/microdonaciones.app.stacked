class UnitType {
  final int id;
  final String tag;
  final String description;

  UnitType({
    required this.id,
    required this.tag,
    required this.description,
  });

  /// Crea una instancia de [UnitType]
  factory UnitType.createOne(Map json) {
    return UnitType(
      id: json['id'],
      tag: json['tag'],
      description: json['description'],
    );
  }
}
