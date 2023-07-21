import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class SelectDeliveryMethodViewModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  void onChangeTypeDelivery(TypeDelivery type) {}
}
