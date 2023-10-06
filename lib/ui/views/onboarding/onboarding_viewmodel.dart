import 'package:flutter/material.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final PageController _pageController = PageController(initialPage: 0);
  final int numSlides = 3;
  int currentPage = 0;

  PageController get pageController => _pageController;

  /// Actualiza la referencia de [currentPage]
  void onPageChange(int page) {
    currentPage = page;
    rebuildUi();
  }

  /// Navega a la pantalla de home y la hace root.
  void navigateToHome() {
    /// Marco que se vio el onboarding para que no se vuelva a mostrar.
    StorageHelper.saveOnboarding(true);

    _navigationService.replaceWithHomeView();
  }

  /// Devuelve true si la slide que se esta mostrando es la ultima.
  bool get isLastPage => (currentPage == (numSlides - 1));
}
