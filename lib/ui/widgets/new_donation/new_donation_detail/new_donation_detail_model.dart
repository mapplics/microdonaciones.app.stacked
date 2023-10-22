import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/new_donation/delivery_new_donation.model.dart';
import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:microdonations/core/models/new_donation/pickup_new_donation.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class NewDonationDetailModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Devuelve los productos que selecciono el usuario para donar.
  List<DonationProduct> get products => _newDonationService.donationsItems;

  String? get presentation => _newDonationService.pickupTimeDetail;

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

  OngReceptionPoint? get receptionPoint => _newDonationService.receptionPoint;
}
