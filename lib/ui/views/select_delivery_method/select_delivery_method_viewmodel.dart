import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class SelectDeliveryMethodViewModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  TypeDelivery get typeDeliverySelected =>
      _newDonationService.selectedTypeDelivery;

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(TypeDelivery type) {
    _newDonationService.updateTypeDelivery(type);
    rebuildUi();
  }
}
