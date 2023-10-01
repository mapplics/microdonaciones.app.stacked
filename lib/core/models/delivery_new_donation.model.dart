import 'package:microdonations/core/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

import 'reception_point.model.dart';

class DeliveryNewDonation extends BaseNewDonation {
  late ReceptionPoint? _receptionPoint;

  DeliveryNewDonation({super.type = ShippingMethod.pickup});

  @override
  set setDonationItemsDetail(DonationItemsDetail items) {
    donationItemsDetail = items;
  }

  @override
  set setOng(Ong selectedOng) {
    ong = selectedOng;
  }

  set setReceptionPoint(ReceptionPoint receptionPoint) {
    _receptionPoint = receptionPoint;
  }

  ReceptionPoint? get receptionPoint => _receptionPoint;

  /// Devuelve true si la instancia [PickupDonation]
  /// es valida como para crear una donacion.
  bool valid() {
    return (_receptionPoint != null);
  }

  /// Resetea todos los campos.
  void resetFields() {
    _receptionPoint = null;
  }

  @override
  toJson() {
    return {
      "ong_id": ong.id,
      "shipping_method": 'delivery',
      "reception_point_id": _receptionPoint!.id,
      "products": donationItemsDetail.donationsItemsList
          .map(
            (donationItem) => {
              'id': donationItem.product.id,
              'quantity': donationItem.quantity
            },
          )
          .toList(),
    };
  }
}
