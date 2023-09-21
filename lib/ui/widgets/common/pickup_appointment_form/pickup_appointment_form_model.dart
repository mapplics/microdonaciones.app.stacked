import 'dart:async';

import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/enums/weekday.enum.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

enum PickupAppointmentFormFields {
  day,
  time,
}

class PickupAppointmentFormModel extends BaseViewModel {
  final _newDonationDataService = locator<NewDonationDataService>();
  final OnChangeForm onchange;
  List<CustomDropdownItems<PickupDropdownValue>> _timeItems = [];

  PickupAppointmentFormModel(this.onchange);

  late FormGroup _formGroup;

  FormGroup get formGroup => _formGroup;

  final List<StreamSubscription<dynamic>> _formSubscriptions = [];

  List<CustomDropdownItems<PickupDropdownValue>> get timeItems {
    final dateTime = ReactiveFormHelper.getControlValue(
        _formGroup, PickupAppointmentFormFields.day.name);

    if (dateTime != null) {
      _loadTimeItems(dateTime);
      return _timeItems;
    } else {
      return [];
    }
  }

  DateTime? get deliveryDay =>
      _formGroup.control(PickupAppointmentFormFields.day.name).value;

  void initForm(FormGroup? form) {
    _formGroup = form ??
        FormGroup(
          {
            PickupAppointmentFormFields.day.name: FormControl<DateTime>(
              value: null,
              validators: [Validators.required],
            ),
            PickupAppointmentFormFields.time.name:
                FormControl<PickupDropdownValue>(
              value: null,
              disabled: true,
              validators: [Validators.required],
            ),
          },
        );

    _formSubscriptions.add(
      _formGroup.valueChanges.listen((_) => onchange(_formGroup)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onchange(_formGroup);
    });
  }

  void updateDate(DateTime value) {
    _formGroup.control(PickupAppointmentFormFields.day.name).updateValue(value);
    _formGroup.control(PickupAppointmentFormFields.time.name).markAsEnabled();
    _formGroup.control(PickupAppointmentFormFields.time.name).updateValue(null);
    rebuildUi();
  }

  /// Setea la hora y dia en que se le retira la donacion al usuario.
  void updateTime<T>(T value) {
    final pickupValue = value as PickupDropdownValue;
    _formGroup.control(PickupAppointmentFormFields.time.name).value =
        pickupValue;
  }

  /// Devuelve true si el campo [PickupAppointmentFormFields.day] es requerido
  bool get dayFieldIsRequired {
    return ReactiveFormHelper.isRequiredField(
      _formGroup,
      PickupAppointmentFormFields.day.name,
    );
  }

  /// Devuelve true si el campo [PickupAppointmentFormFields.time] es requerido
  bool get timeFieldIsRequired {
    return ReactiveFormHelper.isRequiredField(
      _formGroup,
      PickupAppointmentFormFields.time.name,
    );
  }

  /// Devuelve una lista de opciones para un dropdown con la hora
  /// y el dia disponible para que le retiren la donacion al usuario.
  void _loadTimeItems(DateTime dateTime) {
    _timeItems = [];

    final Weekday weekday = DateTimeHelper.getDayOfWeek(dateTime);

    final range = _newDonationDataService.pickupRange.firstWhere(
      (element) => element.weekday.toLowerCase() == weekday.name.toLowerCase(),
    );

    _timeItems.addAll(range.prepareForDropdown());
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
