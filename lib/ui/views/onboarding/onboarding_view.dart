import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
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
                    bottom: MediaQuery.of(context).size.height / 5.7),
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
                height: 20,
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

class PageIndicator extends StatelessWidget {
  final int pageSize;
  final int currentPage;

  const PageIndicator({
    required this.pageSize,
    required this.currentPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pageSize; i++)
          Padding(
            padding: EdgeInsets.only(right: (i != (pageSize - 1)) ? 20.0 : 0.0),
            child: DotIndicator(
              active: (i == currentPage),
            ),
          )
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool active;
  const DotIndicator({required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: active
            ? [
                BoxShadow(
                  color: CustomStylesTheme.tertiaryColor.withOpacity(0.3),
                  blurRadius: 7.0,
                )
              ]
            : null,
        color: active
            ? CustomStylesTheme.tertiaryColor
            : CustomStylesTheme.darkGreyColor,
      ),
    );
  }
}
