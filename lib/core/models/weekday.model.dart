/// Representa un dia de la semana.
class Weekday {
  final String tag;
  final String name;

  Weekday({
    required this.tag,
    required this.name,
  });

  static Weekday createOne(Map data) {
    return Weekday(
      tag: data['tag'],
      name: data['name'],
    );
  }
}
