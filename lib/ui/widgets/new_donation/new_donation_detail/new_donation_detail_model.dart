import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/pickup_new_donation.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/new_donation/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class NewDonationDetailModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Devuelve los productos que selecciono el usuario para donar.
  List<DonationItem> get products => _newDonationService.donationsItems;

  PickupWeekDayRangePresentation? get presentation =>
      _newDonationService.pickupPresentation;

  /// Devuelve el metodo de entrega de la donacion.
  ShippingMethod get shippingMethod => _newDonationService.deliveryTypeValue;

  DeliveryNewDonation? get deliveryOrder {
    if (ShippingMethod.delivery == shippingMethod) {
      return _newDonationService.deliveryDonation;
    } else {
      return null;
    }
  }

  PickupDonation? get pickupDonation {
    if (ShippingMethod.pickup == shippingMethod) {
      return _newDonationService.pickupDonation;
    } else {
      return null;
    }
  }

  String? get userAddres => pickupDonation?.userAddress!.fullAddress;

  ReceptionPoint? get receptionPoint => _newDonationService.receptionPoint;
}
