import 'package:flutter/material.dart';
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
        appbar: const CustomAppbar(title: 'Formulario'),
        body: Column(
          children: [
            UserInformationForm(
              user: viewParameters.user,
              onchange: (form) => viewModel.updateForm = form,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (_) {},
                  ),
                  Text(
                    'Acepto todos los términos y condiciones',
                    style: CustomStylesTheme.regular14_24.copyWith(
                      color: CustomStylesTheme.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 43.0),
              child: CustomFillButton(
                backgroundColor: CustomStylesTheme.tertiaryColor,
                label: 'Crear una cuenta',
                action: viewModel.onSaveUserData,
              ),
            )
          ],
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
