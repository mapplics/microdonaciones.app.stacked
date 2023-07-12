import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/focus.helpers.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_fill_button/custom_fill_button.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/user_information_form/user_information_form.dart';
import 'package:stacked/stacked.dart';

import '../../../core/parameters/personal_information_view.parameters.model.dart';
import 'personal_information_viewmodel.dart';

class PersonalInformationView
    extends StackedView<PersonalInformationViewModel> {
  final UserInformationFormParameters viewParameters;

  const PersonalInformationView({
    required this.viewParameters,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PersonalInformationViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: FocusHelper.closeKeyboard,
      child: CustomScaffold(
        appbar: const CustomAppbar(
          title: 'Datos personales',
          actions: [],
        ),
        body: Column(
          children: [
            UserInformationForm(
              user: viewParameters.user,
              onchange: (form) => viewModel.updateForm = form,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 43.0),
              child: CustomFillButton(
                backgroundColor: CustomStylesTheme.tertiaryColor,
                label: 'Guardar',
                action: () => viewModel.onSaveUserData(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  PersonalInformationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PersonalInformationViewModel();
}
