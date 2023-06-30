import 'package:flutter/material.dart';
import 'package:microdonations/core/forms_validators/text_form_field.validators.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/views/personal_information/personal_information_view.form.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../core/parameters/personal_information_view.parameters.model.dart';
import '../../widgets/common/user_avatar/user_avatar.dart';
import 'personal_information_viewmodel.dart';

enum PersonalInformationFormFields { name, surname, phone, address }

@FormView(
  fields: [
    FormTextField(name: 'name', validator: TextFormFieldValidators.notEmpty),
    FormTextField(name: 'surname'),
    FormTextField(name: 'phone'),
    FormTextField(name: 'address'),
  ],
)
class PersonalInformationView extends StackedView<PersonalInformationViewModel>
    with $PersonalInformationView {
  final PersonalInformationViewParameters? firebaseUser;

  const PersonalInformationView({
    this.firebaseUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PersonalInformationViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomScaffold(
        appbar: const CustomAppbar(title: 'Formulario'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(
              canUploadImg: true,
              fullname:
                  firebaseUser!.firebaseUser.displayName ?? 'user anonymous',
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
        ),
      ),
    );
  }

  @override
  void onViewModelReady(PersonalInformationViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.initForm(firebaseUser!.firebaseUser);
  }

  @override
  void onDispose(PersonalInformationViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  PersonalInformationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PersonalInformationViewModel();
}
