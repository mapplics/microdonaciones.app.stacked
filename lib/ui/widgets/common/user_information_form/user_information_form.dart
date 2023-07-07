import 'package:flutter/material.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../custom_text_field/custom_input_text.dart';
import '../user_avatar/user_avatar.dart';
import 'user_information_form_model.dart';

typedef OnChangeValue = void Function(FormGroup form);

class UserInformationForm extends StackedView<UserInformationFormModel> {
  final BaseUser user;
  final OnChangeValue onchange;

  const UserInformationForm({
    required this.onchange,
    required this.user,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    UserInformationFormModel viewModel,
    Widget? child,
  ) {
    return (!viewModel.isFormInitialized)
        ? const Center(child: CircularProgressIndicator())
        : ReactiveForm(
            formGroup: viewModel.formGroup!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(
                  canUploadImg: true,
                  user: user,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 66, bottom: 24.0),
                  child: CustomInputText(
                    label: 'Nombre',
                    hintText: 'Ingresá tu nombre',
                    formControlName: UserInformationFormFields.name.name,
                    validationMessage: ReactiveFormHelper.getValidationMessages,
                    isRequired: ReactiveFormHelper.isRequiredField(
                      viewModel.formGroup!,
                      UserInformationFormFields.name.name,
                    ),
                  ),
                ),
                CustomInputText(
                  label: 'Apellido',
                  hintText: 'Ingresá tu apellido',
                  formControlName: UserInformationFormFields.surname.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
                  isRequired: ReactiveFormHelper.isRequiredField(
                    viewModel.formGroup!,
                    UserInformationFormFields.surname.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: CustomInputText(
                    label: 'Telefono',
                    hintText: 'Ingresá tu telefono',
                    formControlName: UserInformationFormFields.phone.name,
                    validationMessage: ReactiveFormHelper.getValidationMessages,
                    isRequired: ReactiveFormHelper.isRequiredField(
                      viewModel.formGroup!,
                      UserInformationFormFields.phone.name,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                CustomInputText(
                  label: 'Dirección',
                  hintText: 'Ingresá tu dirección',
                  formControlName: UserInformationFormFields.address.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
                  isRequired: ReactiveFormHelper.isRequiredField(
                    viewModel.formGroup!,
                    UserInformationFormFields.address.name,
                  ),
                ),
              ],
            ),
          );
  }

  @override
  void onViewModelReady(UserInformationFormModel viewModel) {
    viewModel.initForm(user);
  }

  @override
  void onDispose(UserInformationFormModel viewModel) {
    super.onDispose(viewModel);
    viewModel.disposeForm();
  }

  @override
  UserInformationFormModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserInformationFormModel(action: onchange);
}
