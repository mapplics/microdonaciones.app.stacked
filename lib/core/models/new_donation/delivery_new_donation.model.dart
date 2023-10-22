// ignore_for_file: avoid_init_to_null

import 'package:microdonations/core/models/new_donation/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/new_donation/donation_product_list.model.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

import '../ong/ong_reception_point.model.dart';

/// Representa una donacion que el usuario va a llevar a un punto de entrega.
/// Esta clase es la que se parsea y se envia a la API.
class DeliveryNewDonation extends BaseNewDonation {
  late OngReceptionPoint? _receptionPoint = null;

  DeliveryNewDonation({super.type = ShippingMethod.pickup});

  @override
  set setDonationItemsDetail(DonationProductList items) {
    donationItemsDetail = items;
  }

  @override
  set setOng(Ong selectedOng) {
    ong = selectedOng;
  }

  set setReceptionPoint(OngReceptionPoint receptionPoint) {
    _receptionPoint = receptionPoint;
  }

  OngReceptionPoint? get receptionPoint => _receptionPoint;

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
