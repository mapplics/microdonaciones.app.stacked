/// Representa un rando de horario.
class RangeTime {
  final int id;
  final String start;
  final String end;

  RangeTime({
    required this.id,
    required this.end,
    required this.start,
  });

  static RangeTime createOne(Map<String, dynamic> data) {
    return RangeTime(
      id: data['id'],
      start: data['timeOpen'],
      end: data['timeClose'],
    );
  }

  /// Devuelve el rango de tiempo en formato 'hh:mm a hh:mm'
  /// Ejemplo: 12:00 a 13:00
  String get fullTime =>
      '${_removeMiliseconds(start)} a ${_removeMiliseconds(end)}';

  /// Devuelve el rango de tiempo en formato 'hh:mm y las hh:mm'
  /// Ejemplo: 12:00 y las 13:00
  String get betweenTime =>
      '${_removeMiliseconds(start)} y las ${_removeMiliseconds(end)}';

  /// Devuelve [start] o [end] sin los milisegundos.
  static String _removeMiliseconds(String time) => time.substring(0, 5);
}
