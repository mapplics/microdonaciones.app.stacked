import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class SelectDeliveryMethodViewModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _userService = locator<UserService>();

  TypeDelivery get typeDeliverySelected =>
      _newDonationService.selectedTypeDelivery;

  UserAddress get userAddress => _userService.loggedUser.address;

  /// Devuelve true si el tipo de delivery [TypeDelivery] seleccionado
  /// es a domicilio.
  bool get isHomeDelivery =>
      _newDonationService.selectedTypeDelivery == TypeDelivery.home;

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(TypeDelivery type) {
    _newDonationService.updateTypeDelivery(type);
    rebuildUi();
  }
}
