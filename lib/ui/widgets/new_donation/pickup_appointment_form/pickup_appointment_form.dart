import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/widgets/common/custom_text_area/custom_text_area.dart';
import 'package:microdonations/ui/widgets/forms/custom_dropdown/custom_dropdown.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'pickup_appointment_form_model.dart';

class PickupAppointmentForm extends StackedView<DeliveryAppointmentFormModel> {
  final OnChangeForm onchange;
  final FormGroup? form;

  const PickupAppointmentForm({required this.onchange, this.form, super.key});

  @override
  Widget builder(
    BuildContext context,
    DeliveryAppointmentFormModel viewModel,
    Widget? child,
  ) {
    return ReactiveForm(
      formGroup: viewModel.formGroup,
      child: Column(
        children: [
          CustomDropdown(
            label: 'Seleccioná un día para que retiremos tu donación',
            required: viewModel.dayFieldIsRequired,
            formControlName: DeliveryAppointmentFormFields.day.name,
            items: viewModel.dayItems,
            onchange: viewModel.updateDate,
            // initialValue: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: CustomDropdown(
              label: 'Seleccioná un horarío',
              required: viewModel.timeFieldIsRequired,
              formControlName: DeliveryAppointmentFormFields.time.name,
              items: viewModel.timeItems,
              onchange: viewModel.updateTime,
              // initialValue: null,
            ),
          ),
          CustomTextArea(
            label: 'Aclaraciones',
            formControlName: DeliveryAppointmentFormFields.observations.name,
          )
        ],
      ),
    );
  }

  @override
  void onViewModelReady(DeliveryAppointmentFormModel viewModel) {
    viewModel.initForm(form);
  }

  @override
  void onDispose(DeliveryAppointmentFormModel viewModel) {
    super.onDispose(viewModel);
    viewModel.disposeForm();
  }

  @override
  DeliveryAppointmentFormModel viewModelBuilder(
    BuildContext context,
  ) =>
      DeliveryAppointmentFormModel(onchange);
}
