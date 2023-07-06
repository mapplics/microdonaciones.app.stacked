import 'package:flutter/material.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/ui/common/helpers/reactive_form.helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../custom_text_field/custom_input_text.dart';
import '../user_avatar/user_avatar.dart';
import 'user_information_form_model.dart';

class UserInformationForm extends StackedView<UserInformationFormModel> {
  final BaseUser user;

  const UserInformationForm({required this.user, super.key});

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
                CustomInputText(
                  label: 'Nombre',
                  hintText: 'Ingresá tu nombre',
                  formControlName: UserInformationFormFields.name.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
                ),
                CustomInputText(
                  label: 'Apellido',
                  hintText: 'Ingresá tu apellido',
                  formControlName: UserInformationFormFields.surname.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
                ),
                CustomInputText(
                  label: 'Telefono',
                  hintText: 'Ingresá tu telefono',
                  formControlName: UserInformationFormFields.phone.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
                  keyboardType: TextInputType.phone,
                ),
                CustomInputText(
                  label: 'Dirección',
                  hintText: 'Ingresá tu dirección',
                  formControlName: UserInformationFormFields.address.name,
                  validationMessage: ReactiveFormHelper.getValidationMessages,
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
  UserInformationFormModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserInformationFormModel();
}
