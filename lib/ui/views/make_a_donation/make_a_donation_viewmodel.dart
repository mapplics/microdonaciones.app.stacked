import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:stacked/stacked.dart';

class MakeADonationViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_newDonationService];

  final PageController pageController = PageController(initialPage: 0);
  final int numPages = 4;
  int currentPage = 0;

  void onPageChange(int page) {
    currentPage = page;
    rebuildUi();
  }

  /// Devuelve true si se debe mostrar el boton para retroceder una pagina.
  bool get canShowGoBackBtn => currentPage != 0;

  bool canEnableNextPage() {
    switch (currentPage) {
      case 0:
        return _newDonationService.selectedItemsIsNotEmpty;
      default:
        return true;
    }
  }

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

  /// Resetea el servicio de [NewDonationService]
  void disposeService() {
    _newDonationService.resetNewDonation();
  }
}
