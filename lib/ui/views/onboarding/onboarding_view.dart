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
                    'Occaecat deserunt et sit dolore do deserunt dolore aute cupidatat cupidatat do ad. Sint eu quis exercitation eiusmod veniam ea cupidatat.',
              ),
              OnboardingPage(
                pathImg: 'assets/img/img_foto_dos.png',
                description:
                    'Et ad aliquip labore ex quis pariatur id. Enim do adipisicing nulla eiusmod laboris elit cillum adipisicing elit sint consequat. Lorem cillum aliquip incididunt culpa qui quis ullamco.',
              ),
              OnboardingPage(
                pathImg: 'assets/img/img_foto_tres.png',
                description:
                    'Do ullamco nostrud laboris consequat reprehenderit officia laboris fugiat aliqua ea culpa et ut. Ea sunt excepteur aliqua aliquip eiusmod dolor. Deserunt ad Lorem ad ullamco ex consectetur culpa quis.',
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
