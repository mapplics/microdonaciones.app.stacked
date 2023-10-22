import 'dart:async';

import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/dropdowns/pickup_day_dropdown_value.model.dart';
import 'package:microdonations/core/models/dropdowns/time_pickup_dropdown_value.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

enum DeliveryAppointmentFormFields {
  day,
  time,
  observations,
}

class DeliveryAppointmentFormModel extends BaseViewModel {
  final _newDonationDataService = locator<NewDonationDataService>();
  final OnChangeForm onchange;
  List<CustomDropdownItems<TimePickupDropdownValue>> _timeItems = [];

  DeliveryAppointmentFormModel(this.onchange);

  late FormGroup formGroup;

  final List<StreamSubscription<dynamic>> _formSubscriptions = [];

  List<CustomDropdownItems<DatePickupDropdownValue>> get dayItems {
    return _newDonationDataService.pickupRange
        .map((e) => e.getDropdownDays())
        .toList();
  }

  List<CustomDropdownItems<TimePickupDropdownValue>> get timeItems {
    final value = ReactiveFormHelper.getControlValue(
        formGroup, DeliveryAppointmentFormFields.day.name);

    if (value != null) {
      final dropdownValue = value as DatePickupDropdownValue;

      _loadTimeItems(dropdownValue.date);
      return _timeItems;
    } else {
      return [];
    }
  }

  void initForm(FormGroup? form) {
    formGroup = form ??
        FormGroup(
          {
            DeliveryAppointmentFormFields.day.name:
                FormControl<DatePickupDropdownValue>(
              value: null,
              validators: [Validators.required],
            ),
            DeliveryAppointmentFormFields.time.name:
                FormControl<TimePickupDropdownValue>(
              value: null,
              disabled: true,
              validators: [Validators.required],
            ),
            DeliveryAppointmentFormFields.observations.name:
                FormControl<String>(
              value: null,
              disabled: false,
              validators: [],
            ),
          },
        );

    _formSubscriptions.add(
      formGroup.valueChanges.listen((_) => onchange(formGroup)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onchange(formGroup);
    });
  }

  void updateDate<T>(T value) {
    logSucess('entro');
    final pickupValue = value as FormControl<DatePickupDropdownValue>;

    formGroup
        .control(DeliveryAppointmentFormFields.day.name)
        .updateValue(pickupValue.value);

    formGroup.control(DeliveryAppointmentFormFields.time.name).markAsEnabled();

    formGroup
        .control(DeliveryAppointmentFormFields.time.name)
        .updateValue(null);

    rebuildUi();
  }

  /// Setea la hora y dia en que se le retira la donacion al usuario.
  void updateTime<T>(T value) {
    final pickupValue = value as FormControl<TimePickupDropdownValue>;
    formGroup.control(DeliveryAppointmentFormFields.time.name).value =
        pickupValue.value;
  }

  /// Devuelve true si el campo [DeliveryAppointmentFormFields.day] es requerido
  bool get dayFieldIsRequired {
    return ReactiveFormHelper.isRequiredField(
      formGroup,
      DeliveryAppointmentFormFields.day.name,
    );
  }

  /// Devuelve true si el campo [DeliveryAppointmentFormFields.time] es requerido
  bool get timeFieldIsRequired {
    return ReactiveFormHelper.isRequiredField(
      formGroup,
      DeliveryAppointmentFormFields.time.name,
    );
  }

  /// Devuelve horarios los horarios para el dia seleccionado.
  void _loadTimeItems(DateTime dateTime) {
    _timeItems = [];

    final range = _newDonationDataService.pickupRange
        .firstWhere((element) => element.weekday.tag == dateTime);

    _timeItems.addAll(range.getDropdownRanges());
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
