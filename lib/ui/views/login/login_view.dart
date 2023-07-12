import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/custom_outline_button/custom_outline_button.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

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
            SvgPicture.asset(
              'assets/logos/ic_logovioleta.svg',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 26),
              child: Text(
                'Ingresar con tu cuenta',
                style: CustomStylesTheme.bold16_24.copyWith(
                  color: CustomStylesTheme.tertiaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 22.0,
              ),
              child: SizedBox(
                width: 260,
                child: CustomOutlineButton(
                  label: 'Ingresar con Google',
                  icon: Icon(
                    PhosphorIcons.fill.googleLogo,
                    color: CustomStylesTheme.tertiaryColor,
                    size: 30.0,
                  ),
                  action: () => viewModel.useGoogleAuthentication(context),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(
                'Laboris proident fugiat sit ut adipisicing officia reprehenderit. Voluptate officia in labore reprehenderit exercitation.',
                textAlign: TextAlign.center,
                style: CustomStylesTheme.regular14_20.copyWith(
                  color: CustomStylesTheme.blackColor,
                ),
              ),
            ),
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
