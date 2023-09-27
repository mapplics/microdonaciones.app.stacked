import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';

class RangeTime {
  final int id;
  final DateTime start;
  final DateTime end;

  RangeTime({
    required this.id,
    required this.end,
    required this.start,
  });

  static RangeTime createOne(Map<String, dynamic> data) {
    return RangeTime(
      id: data['id'],
      end: DateTime.parse("2023-09-25T17:14:10.000000Z"),
      start: DateTime.parse("2023-09-25T17:14:10.000000Z"),
    );
  }

  /// Devuelve como String el rango de tiempo en formato 'hh:mm a hh:mm'
  String get fullTime =>
      '${DateTimeHelper.formatTime(start)} a ${DateTimeHelper.formatTime(end)}';

  /// Devuelve como String el rango de tiempo en formato 'hh:mm y las hh:mm'
  String get betweenTime =>
      '${DateTimeHelper.formatTime(start)} y las ${DateTimeHelper.formatTime(end)}';
}
