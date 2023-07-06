import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/parameters/create_account_view.parameters.model.dart';
import '../../widgets/common/custom_appbar/custom_appbar.dart';
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
        body: UserInformationForm(
          user: viewParameters.firebaseUser,
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
