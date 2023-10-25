import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/forms/terms_and_conditions_checkbox/terms_and_conditions_checkbox.dart';
import 'package:stacked/stacked.dart';

import '../../../core/parameters/create_account_view.parameters.model.dart';
import '../../common/app_theme.dart';
import '../../widgets/common/custom_appbar/custom_appbar.dart';
import '../../widgets/common/custom_fill_button/custom_fill_button.dart';
import '../../widgets/common/custom_scaffold/custom_scaffold.dart';
import '../../widgets/common/user_information_form/user_information_form.dart';
import 'create_account_viewmodel.dart';

class CreateAccountView extends StackedView<CreateAccountViewModel> {
  final CreateAccountViewParameters viewParameters;

  const CreateAccountView({required this.viewParameters, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateAccountViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomScaffold(
        appbar: const CustomAppbar(title: 'Crear cuenta', showActions: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UserInformationForm(
                user: viewParameters.user,
                onchange: (form) => viewModel.updateForm = form,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 30.0),
                child: TermsAndConditionsCheckbox(
                  onchange: (newValue) =>
                      viewModel.termsAndConditionsOnChange(newValue),
                ),
              ),
              CustomFillButton(
                backgroundColor: AppTheme.tertiaryColor,
                label: 'Crear una cuenta',
                action: () => viewModel.onSaveUserData(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  CreateAccountViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateAccountViewModel();
}
