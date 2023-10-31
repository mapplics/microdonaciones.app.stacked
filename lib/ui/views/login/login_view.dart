import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/custom_outline_button/custom_outline_button.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  /// Si es true al terminar el login navega al selector de ONG.
  /// Si es falso navega al home.
  final bool navigateOngSelector;

  const LoginView({Key? key, this.navigateOngSelector = false})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: '',
        showActions: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 42.0),
              child: Image.asset(
                'assets/icons/Icono_app-06.png',
                scale: 1.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 10.0),
              child: Text(
                'Ingresar con tu cuenta',
                style: AppTheme.bold16_24.copyWith(
                  color: AppTheme.tertiaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 12.0,
              ),
              child: SizedBox(
                width: 260,
                child: CustomOutlineButton(
                  label: 'Ingresar con Google',
                  icon: const Icon(
                    PhosphorIcons.googleLogoFill,
                    color: AppTheme.tertiaryColor,
                    size: 30.0,
                  ),
                  action: () => viewModel.useGoogleAuthentication(context),
                ),
              ),
            ),
            viewModel.isApple()
                ? SizedBox(
                    width: 260,
                    child: CustomOutlineButton(
                      label: 'Ingresar con Apple',
                      icon: const Icon(
                        PhosphorIcons.appleLogoFill,
                        color: AppTheme.tertiaryColor,
                        size: 30.0,
                      ),
                      action: () => viewModel.useAppleAuthentication(context),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel(navigateOngSelector: navigateOngSelector);
}
