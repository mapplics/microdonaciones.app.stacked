import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/helpers/launcher_url.helpers.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:stacked/stacked.dart';

class NewCollaboratorModel extends BaseViewModel {
  Future<void> navigateNewCollaborator(BuildContext ctx) async {
    try {
      await LaunchUrlHelper.openUrl(
        'https://docs.google.com/forms/d/e/1FAIpQLSfaDNIyxfXZpx6vyjYgN4Mc7s0v13bxS5aMBTlONBp3fiR_gQ/viewform?usp=sf_link',
      );
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        ctx,
        'Tuvimos un problema al redirigirte. Por favor, volve a intentarlo mas tarde.',
      );
    }
  }
}
