import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/user_avatar/user_avatar.dart';
import 'personal_information_viewmodel.dart';

class PersonalInformationView
    extends StackedView<PersonalInformationViewModel> {
  const PersonalInformationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PersonalInformationViewModel viewModel,
    Widget? child,
  ) {
    return const CustomScaffold(
      appbar: CustomAppbar(title: 'Formulario'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(canUploadImg: true),
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
