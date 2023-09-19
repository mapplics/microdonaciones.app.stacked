import 'dart:async';

import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
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

  PickupAppointmentFormModel(this.onchange);

  late FormGroup _formGroup;

  FormGroup get formGroup => _formGroup;

  final List<StreamSubscription<dynamic>> _formSubscriptions = [];

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
              // disabled: true,
              validators: [Validators.required],
            ),
          },
        );

    _formSubscriptions.add(
      _formGroup.valueChanges.listen((_) => onchange(_formGroup)),
    );
  }

  void updateDate(DateTime value) {
    _formGroup.control(PickupAppointmentFormFields.day.name).value = value;

    final fieldValue = ReactiveFormHelper.getControlValue(
      _formGroup,
      PickupAppointmentFormFields.day.name,
    );

    if (fieldValue != null) {
      _formGroup.control(PickupAppointmentFormFields.time.name).markAsEnabled();
      _formGroup
          .control(PickupAppointmentFormFields.time.name)
          .updateValueAndValidity();
    }

    _formGroup.updateValueAndValidity();
  }

  /// Setea la hora y dia en que se le retira la donacion al usuario.
  void updateTime<T>(T value) {
    final pickupValue = value as PickupDropdownValue;
    _formGroup.control(PickupAppointmentFormFields.time.name).value =
        pickupValue;
  }

  /// Devuelve una lista de opciones para un dropdown con la hora
  /// y el dia disponible para que le retiren la donacion al usuario.
  List<CustomDropdownItems<PickupDropdownValue>> get getPickupOptions {
    List<CustomDropdownItems<PickupDropdownValue>> items = [];

    _newDonationDataService.pickupRange.forEach((element) {
      items.addAll(element.prepareForDropdown());
    });

    return items;
  }

  /// Cancela todas las subscripciones del formulario.
  void disposeForm() {
    logWarn('dISPOSE');
    for (var subscription in _formSubscriptions) {
      subscription.cancel();
    }
  }
}
