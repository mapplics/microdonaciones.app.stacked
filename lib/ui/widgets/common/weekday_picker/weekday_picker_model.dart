import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microdonations/core/enums/weekday.enum.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

class WeekdayPickerModel extends BaseViewModel {
  final OnChangeWeekdayPicker onchange;

  WeekdayPickerModel(this.onchange);

  TextEditingController controller = TextEditingController();

  /// Abre un datePicker.
  openDatePicker(BuildContext ctx) {
    final minDate = DateTime.now().add(const Duration(days: 2));
    final maxDate = DateTime.now().add(const Duration(days: 32));

    showDatePicker(
      context: ctx,
      initialDate: minDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (_, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              headlineMedium: CustomStylesTheme.bold16_20,
            ),
            colorScheme: const ColorScheme.dark(
              primary: CustomStylesTheme.secondaryColor,
              surface: CustomStylesTheme.secondaryColor,
              onSurface: CustomStylesTheme.blackColor,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: CustomStylesTheme.backgroundColor,
          ),
          child: child!,
        );
      },
    ).then((DateTime? value) {
      if (value != null) {
        onchange(value);
        rebuildUi();
      }
    });
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  Weekday _getDayOfWeek(int weekday) {
    switch (weekday) {
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
}
