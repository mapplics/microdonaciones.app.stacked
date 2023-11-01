import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:stacked/stacked.dart';

import 'about_viewmodel.dart';

class AboutView extends StackedView<AboutViewModel> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AboutViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Código Fuente',
        showActions: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Image.asset(
                'assets/icons/Icono_app-06.png',
                scale: 1.8,
              ),
            ),
            Text(
              'Código Fuente',
              style: AppTheme.bold24_32.copyWith(
                color: AppTheme.tertiaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 38.0),
              child: Text(
                '''Somos una asociación civil sin fines de lucro. Nuestro principal objetivo es poner la tecnología al servicio de la comunidad, aportando desde nuestro lugar herramientas tecnológicas que permitan acercarnos con pequeños pero grandes pasos a soluciones digitales como respuesta a diversas problemáticas sociales.''',
                style: AppTheme.regular18_24.copyWith(
                  color: AppTheme.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '¿Queres la app Microdonaciones\npara tu organización?',
                style: AppTheme.bold16_24.copyWith(
                  color: AppTheme.tertiaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            CustomOutlineButton(
              label: 'MÁS INFORMACIÓN',
              action: () => viewModel.navigateNewCollaborator(context),
              mainColor: AppTheme.tertiaryColor,
              textStyle: AppTheme.regular14_16.copyWith(
                color: AppTheme.tertiaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AboutViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AboutViewModel();
}
