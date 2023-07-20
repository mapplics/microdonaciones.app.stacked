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
      appbar: const CustomAppbar(title: 'Hola!'),
      body: Onboarding(
        skipOnboardingAction: viewModel.navigateToHome,
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();
}

class Onboarding extends StatefulWidget {
  final Function skipOnboardingAction;

  const Onboarding({required this.skipOnboardingAction, super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _numPages = 3;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) => setState(() => _currentPage = page),
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
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 10.7),
                child: PageIndicator(
                  pageSize: _numPages,
                  currentPage: _currentPage,
                ),
              ),
              LinkButton(
                label: 'Omitir introducción',
                action: () => widget.skipOnboardingAction(),
                textStyle: CustomStylesTheme.regular14_20.copyWith(
                  color: CustomStylesTheme.tertiaryColor,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        )
      ],
    );
  }
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
