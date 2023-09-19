import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

class WeekdayPickerModel extends BaseViewModel {
  final OnChangeWeekdayPicker onchange;

  WeekdayPickerModel(this.onchange);

  TextEditingController controller = TextEditingController();

  /// Abre un datePicker.
  openDatePicker(BuildContext ctx, DateTime? initialDate) {
    final minDate = DateTime.now().add(const Duration(days: 2));
    final maxDate = DateTime.now().add(const Duration(days: 32));

    showDatePicker(
      context: ctx,
      initialDate: initialDate ?? minDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (_, child) => Theme(
        data: CustomStylesTheme.dateTimePicker(),
        child: child!,
      ),
    ).then((DateTime? value) {
      if (value != null) {
        onchange(value);
        rebuildUi();
      }
    });
  }
}
