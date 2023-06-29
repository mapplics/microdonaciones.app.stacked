import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../core/parameters/personal_information_view.parameters.model.dart';
import '../../widgets/common/user_avatar/user_avatar.dart';
import 'personal_information_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'name'),
    FormTextField(name: 'surname'),
    FormTextField(name: 'phone'),
    FormTextField(name: 'address'),
  ],
)
class PersonalInformationView
    extends StackedView<PersonalInformationViewModel> {
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
    return CustomScaffold(
      appbar: const CustomAppbar(title: 'Formulario'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(
            canUploadImg: true,
            fullname:
                firebaseUser!.firebaseUser.displayName ?? 'user anonymous',
          ),
        ],
      ),
    );
  }

  @override
  PersonalInformationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PersonalInformationViewModel();
}
