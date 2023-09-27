class Weekday {
  final int id;
  final String tag;
  final String name;

  Weekday({
    required this.id,
    required this.tag,
    required this.name,
  });

  static Weekday createOne(Map<String, dynamic> data) {
    return Weekday(
      id: data['id'],
      tag: data['tag'],
      name: data['name'],
    );
  }
}
