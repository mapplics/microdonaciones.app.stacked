import 'dart:async';

import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/enums/weekday.enum.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

enum DeliveryAppointmentFormFields {
  day,
  time,
}

class DeliveryAppointmentFormModel extends BaseViewModel {
  final _newDonationDataService = locator<NewDonationDataService>();
  final OnChangeForm onchange;
  List<CustomDropdownItems<PickupDropdownValue>> _timeItems = [];

  DeliveryAppointmentFormModel(this.onchange);

  late FormGroup formGroup;

  final List<StreamSubscription<dynamic>> _formSubscriptions = [];

  List<CustomDropdownItems<PickupDropdownValue>> get timeItems {
    final dateTime = ReactiveFormHelper.getControlValue(
        formGroup, DeliveryAppointmentFormFields.day.name);

    if (dateTime != null) {
      _loadTimeItems(dateTime);
      return _timeItems;
    } else {
      return [];
    }
  }

  DateTime? get deliveryDay =>
      formGroup.control(DeliveryAppointmentFormFields.day.name).value;

  void initForm(FormGroup? form) {
    formGroup = form ??
        FormGroup(
          {
            DeliveryAppointmentFormFields.day.name: FormControl<DateTime>(
              value: null,
              validators: [Validators.required],
            ),
            DeliveryAppointmentFormFields.time.name:
                FormControl<PickupDropdownValue>(
              value: null,
              disabled: true,
              validators: [Validators.required],
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

  void updateDate(DateTime value) {
    formGroup
        .control(DeliveryAppointmentFormFields.day.name)
        .updateValue(value);
    formGroup.control(DeliveryAppointmentFormFields.time.name).markAsEnabled();
    formGroup
        .control(DeliveryAppointmentFormFields.time.name)
        .updateValue(null);
    rebuildUi();
  }

  /// Setea la hora y dia en que se le retira la donacion al usuario.
  void updateTime<T>(T value) {
    final pickupValue = value as PickupDropdownValue;
    formGroup.control(DeliveryAppointmentFormFields.time.name).value =
        pickupValue;
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

  /// Devuelve una lista de opciones para un dropdown con la hora
  /// y el dia disponible para que le retiren la donacion al usuario.
  void _loadTimeItems(DateTime dateTime) {
    _timeItems = [];

    final Weekday weekday = DateTimeHelper.getDayOfWeek(dateTime);

    final range = _newDonationDataService.pickupRange.firstWhere((element) {
      final uno = element.weekday.name.removeAccents().toLowerCase();
      final dos = weekday.name.removeAccents().toLowerCase();

      return uno.contains(dos);
    });

    _timeItems.addAll(range.prepareForDropdown());
  }

  List<int> get enabledDays {
    List<int> _enabledDays = [];

    for (var element in _newDonationDataService.pickupRange) {
      int numberDay;

      switch (element.weekday.tag.toLowerCase()) {
        case 'l':
          numberDay = 1;
          break;
        case 'm':
          numberDay = 2;
          break;
        case 'x':
          numberDay = 3;
          break;
        case 'j':
          numberDay = -4;
          break;
        case 'v':
          numberDay = 5;
          break;
        case 's':
          numberDay = 6;
          break;
        case 'd':
          numberDay = 7;
          break;
        default:
          numberDay = -1;
          break;
      }

      if (!_enabledDays.contains(numberDay)) {
        _enabledDays.add(numberDay);
      }
    }

    return _enabledDays;
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
