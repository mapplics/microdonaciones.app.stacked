import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MakeADonationViewModel extends BaseViewModel {
  final PageController pageController = PageController(initialPage: 0);
  final int numPages = 4;
  int currentPage = 0;

  void onPageChange(int page) {
    currentPage = page;
    rebuildUi();
  }

  /// Devuelve true si se debe mostrar el boton para retroceder una pagina.
  bool get canShowGoBackBtn => currentPage != 0;

  //// Navega a la siguiente pagina.
  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 175),
      curve: Curves.linear,
    );
  }

  //// Retrocede una pagina.
  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 175),
      curve: Curves.linear,
    );
  }
}
