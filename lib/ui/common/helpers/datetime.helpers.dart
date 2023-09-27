import 'package:microdonations/core/enums/weekday.enum.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Recibe un [DateTime] y devuelve un [Weekday] del dia de la semana.
  static Weekday getDayOfWeek(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return Weekday.lunes;
      case DateTime.tuesday:
        return Weekday.martes;
      case DateTime.wednesday:
        return Weekday.miercoles;
      case DateTime.thursday:
        return Weekday.jueves;
      case DateTime.friday:
        return Weekday.viernes;
      case DateTime.saturday:
        return Weekday.sabado;
      case DateTime.sunday:
        return Weekday.domingo;
      default:
        return Weekday.unknow;
    }
  }

  /// Recibe un [DateTime] y lo devuelve en formato 'dd/MM/yyyy'
  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  /// Recibe un [DateTime] y lo devuelve en formato hh:mm
  static String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
