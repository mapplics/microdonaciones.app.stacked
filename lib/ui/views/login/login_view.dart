import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_colors.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_outline_button.widget.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.bold.heartHalf,
              color: kcPrimaryColor,
              size: 64,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 32),
              child: Text(
                'Ingresar con tu cuenta',
                style: CustomStylesTheme.bold16_20.copyWith(
                  color: kcPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 260,
                child: CustomOutlineButton(
                  label: 'Ingresar con Google',
                  icon: Icon(
                    PhosphorIcons.fill.googleLogo,
                    color: kcPrimaryColor,
                    size: 30.0,
                  ),
                  action: viewModel.useGoogleAuthentication,
                ),
              ),
            ),
            // CustomOutlineButtonView(label: 'Ingresar con Google'),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
