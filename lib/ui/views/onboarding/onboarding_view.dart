import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/page_indicator/page_indicator.dart';
import 'package:stacked/stacked.dart';

import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(title: '¡Hola!', showActions: false),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: viewModel.pageController,
              onPageChanged: viewModel.onPageChange,
              children: const [
                OnboardingPage(
                  pathImg: 'assets/img/img_foto_uno.png',
                  description:
                      '¡Bienvenidos!\nMicroDonaciones es un desarrollo\nde la Asociación Civil Código Fuente.',
                ),
                OnboardingPage(
                  pathImg: 'assets/img/img_foto_dos.png',
                  description:
                      'Nuestro objetivo es crear soluciones digitales. Donamos nuestro tiempo, coordinamos equipos, desarrollamos tecnologías que generen impacto en la sociedad.',
                ),
                OnboardingPage(
                  pathImg: 'assets/img/img_foto_tres.png',
                  description:
                      'A través de MicroDonaciones vas a poder publicar y hacer el seguimiento de tu donación destinada a distintos merenderos de la ciudad.',
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: PageIndicator(
                      totalSlides: viewModel.numSlides,
                      currentSlide: viewModel.currentPage,
                      withPositionsColors: true,
                    ),
                  ),
                  if (viewModel.isLastPage)
                    CustomOutlineButton(
                      label: '¡Comenzar!',
                      action: viewModel.navigateToHome,
                      textStyle: AppTheme.bold14_20.copyWith(
                        color: AppTheme.tertiaryColor,
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();
}

class OnboardingPage extends StatelessWidget {
  final String description;
  final String pathImg;

  const OnboardingPage({
    required this.description,
    required this.pathImg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          width: _deviceWidth / 1.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Image.asset(
                  pathImg,
                  // width: _deviceWidth,
                  // fit: BoxFit.cover,
                ),
              ),
              Text(
                description,
                style: AppTheme.bold14_16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
