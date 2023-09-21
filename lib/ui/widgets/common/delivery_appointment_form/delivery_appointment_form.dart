import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:microdonations/ui/widgets/common/custom_dropdown/custom_dropdown.dart';
import 'package:microdonations/ui/widgets/common/weekday_picker/weekday_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'delivery_appointment_form_model.dart';

class DeliveryAppointmentForm
    extends StackedView<DeliveryAppointmentFormModel> {
  final OnChangeForm onchange;
  final FormGroup? form;

  const DeliveryAppointmentForm({required this.onchange, this.form, super.key});

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
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: WeekdayPicker(
              formControlName: PickupAppointmentFormFields.day.name,
              label: 'Seleccioná un día para el retiro',
              onchange: viewModel.updateDate,
              required: viewModel.dayFieldIsRequired,
              validationMessage: ReactiveFormHelper.getValidationMessages,
              initialDate: viewModel.deliveryDay,
            ),
          ),
          CustomDropdown(
            label: 'Seleccioná un horarío',
            required: viewModel.timeFieldIsRequired,
            formControlName: PickupAppointmentFormFields.time.name,
            items: viewModel.timeItems,
            onchange: viewModel.updateTime,
            // initialValue: null,
          ),
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
