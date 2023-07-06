import 'package:flutter/material.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../../core/forms_validators/text_form_field.validators.dart';
import '../custom_text_field/custom_text_field.dart';
import '../user_avatar/user_avatar.dart';
import 'user_information_form_model.dart';

enum PersonalInformationFormFields { name, surname, phone, address }

@FormView(
  fields: [
    FormTextField(name: 'name', validator: TextFormFieldValidators.notEmpty),
    FormTextField(name: 'surname'),
    FormTextField(name: 'phone'),
    FormTextField(name: 'address'),
  ],
)
class UserInformationForm extends StackedView<UserInformationFormModel>
    with $UserInformationForm {
  final BaseUser user;

  const UserInformationForm({required this.user, super.key});

  @override
  Widget builder(
    BuildContext context,
    UserInformationFormModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(
          canUploadImg: true,
          user: user,
        ),
        CustomTextField(
          label: 'Nombre',
          hintText: 'Ingresá tu nombre',
          textInputController: nameController,
          errorMessage: viewModel.hasNameValidationMessage
              ? viewModel.nameValidationMessage
              : '',
        ),
        CustomTextField(
          label: 'Apellido',
          hintText: 'Ingresá tu apellido',
          textInputController: surnameController,
          errorMessage: viewModel.hasSurnameValidationMessage
              ? viewModel.surnameValidationMessage
              : '',
        ),
        CustomTextField(
          label: 'Telefono',
          hintText: 'Ingresá tu telefono',
          textInputController: phoneController,
          errorMessage: viewModel.hasPhoneValidationMessage
              ? viewModel.phoneValidationMessage
              : '',
        ),
        CustomTextField(
          label: 'Dirección',
          hintText: 'Ingresá tu dirección',
          textInputController: addressController,
          errorMessage: viewModel.hasAddressValidationMessage
              ? viewModel.addressValidationMessage
              : '',
        ),
      ],
    );
  }

  @override
  void onViewModelReady(UserInformationFormModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.initForm(user);
  }

  @override
  void onDispose(UserInformationFormModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  UserInformationFormModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserInformationFormModel();
}
