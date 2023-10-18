import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

class WeekdayPickerModel extends BaseViewModel {
  final OnChangeWeekdayPicker onchange;
  final DateTime? initialDate;
  final List<int>? enabledDay;

  WeekdayPickerModel({
    required this.onchange,
    required this.initialDate,
    required this.enabledDay,
  });

  TextEditingController controller = TextEditingController();

  /// Abre un datePicker.
  openDatePicker(BuildContext ctx) {
    final startDate = _getInitialDate();
    final maxDate = DateTime.now().add(const Duration(days: 14));

    logSucess(DateTimeHelper.formatDateTime(startDate));

    showDatePicker(
      context: ctx,
      initialDate: startDate,
      firstDate: startDate,
      lastDate: maxDate,
      selectableDayPredicate: _shouldBeSelectable,
      builder: (_, child) => Theme(
        data: AppTheme.dateTimePicker(),
        child: child!,
      ),
    ).then((DateTime? value) {
      if (value != null) {
        onchange(value);
        rebuildUi();
      }
    });
  }

  /// Devuelve la fecha minima para seleccionar en el calendario.
  DateTime _getInitialDate() {
    final defaultDate =
        initialDate ?? DateTime.now().add(const Duration(days: 2));

    if (enabledDay == null) {
      return defaultDate;
    }

    if (enabledDay!.contains(defaultDate.weekday)) {
      return defaultDate;
    } else {
      DateTime nextIntialDate;
      do {
        nextIntialDate = defaultDate.add(const Duration(days: 1));
        logSucess(nextIntialDate.toIso8601String());
      } while (!enabledDay!.contains(nextIntialDate.weekday));

      return nextIntialDate;
    }
  }

  /// Devuelve true si el [date] deberia ser seleccionable
  /// segun la lista de [enabledDay]
  bool _shouldBeSelectable(DateTime date) {
    final day = date.weekday;
    return enabledDay?.contains(day) ?? true;
  }
}
