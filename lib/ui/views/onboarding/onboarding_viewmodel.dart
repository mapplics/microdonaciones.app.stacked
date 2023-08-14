import 'package:flutter/material.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final PageController _pageController = PageController(initialPage: 0);
  final int _numSlides = 3;
  int _currentPage = 0;

  /// Devuelve la cantidad total de slides.
  int get numSlides => _numSlides;

  /// Devuelve la pagina actual del slide que se esta mostrando.
  int get currentPage => _currentPage;

  PageController get pageController => _pageController;

  /// Actualiza la referencia de [_currentPage]
  void onPageChange(int page) {
    _currentPage = page;
    rebuildUi();
  }

  /// Navega a la pantalla de home y la hace root.
  void navigateToHome() {
    /// Marco que se vio el onboarding para que no se vuelva a mostrar.
    StorageHelper.saveOnboarding(true);

    _navigationService.replaceWithHomeView();
  }

  /// Devuelve true si la slide que se esta mostrando es la ultima.
  bool get isLastPage => (_currentPage != (_numSlides - 1));
}
