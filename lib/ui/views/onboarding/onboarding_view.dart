import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
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
      appbar: const CustomAppbar(title: 'Hola!', showActions: false),
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: viewModel.pageController,
            onPageChanged: viewModel.onPageChange,
            children: const [
              OnboardingPage(
                pathImg: 'assets/img/img_foto_uno.png',
                description:
                    'Bienvenidos! MicroDonaciones es un desarrollo de la Asociación Civil Código Fuente.',
              ),
              OnboardingPage(
                pathImg: 'assets/img/img_foto_dos.png',
                description:
                    'Somos una asociación sin fines de lucro que tiene por objetivo la creación de soluciones digitales como respuesta a distintas problemáticas sociales. Donamos nuestro tiempo para la coordinación de equipos y el desarrollo de tecnologías que generen impacto en nuestra sociedad.',
              ),
              OnboardingPage(
                pathImg: 'assets/img/img_foto_tres.png',
                description:
                    'A través de MicroDonaciones vas a poder publicar tu donación especificando qué vas a donar junto con tu dirección, horario y fecha en que podrían pasar a retirarla. También podrás hacer el seguimiento de tus donaciones, las cuales tendrán como destino distintos merenderos de la ciudad.',
              ),
            ],
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PageIndicator(
                  pageSize: viewModel.numSlides,
                  currentPage: viewModel.currentPage,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: [
                      LinkButton(
                        label: viewModel.isLastPage
                            ? 'Omitir introducción'
                            : 'Comenzar!',
                        action: viewModel.navigateToHome,
                        textStyle: CustomStylesTheme.regular14_20.copyWith(
                          color: CustomStylesTheme.tertiaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 18),
                child: Image.asset(
                  pathImg,
                  scale: 2,
                  // color: Colors.red,
                ),
              ),
              Text(
                description,
                style: CustomStylesTheme.regular14_16,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
