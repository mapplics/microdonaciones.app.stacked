import 'package:microdonations/core/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

import 'user_address.model.dart';

class DeliveryNewDonation extends BaseNewDonation {
  late int? _weekdayId;
  late int? _rangeId;
  late DateTime? _pickupDate;
  late UserAddress? _userAddress;

  DeliveryNewDonation({super.type = TypeDelivery.delivery});

  @override
  set setDonationItemsDetail(DonationItemsDetail items) {
    donationItemsDetail = items;
  }

  @override
  set setOng(Ong selectedOng) {
    ong = selectedOng;
  }

  set setWeekdayId(int id) {
    _weekdayId = id;
  }

  int? get weekday => _weekdayId;

  set setRangeId(int id) {
    _rangeId = id;
  }

  int? get rangeId => _rangeId;

  set setPickupDate(DateTime date) {
    _pickupDate = date;
  }

  /// Devuelve la direccion del usuario.
  DateTime? get pickupDate => _pickupDate;

  /// Setea la direccion del usuario.
  set setUserAddress(UserAddress userAddress) {
    _userAddress = userAddress;
  }

  /// Devuelve la direccion del usuario.
  UserAddress? get userAddress => _userAddress;

  /// Devuelve true si la instancia [DeliveryNewDonation]
  /// es valida como para crear una donacion.
  bool valid() {
    return (_weekdayId != null) &&
        (_rangeId != null) &&
        (_pickupDate != null) &&
        (_userAddress != null);
  }

  /// Resetea todos los campos.
  void resetFields() {
    _weekdayId = null;
    _rangeId = null;
    _pickupDate = null;
    _userAddress = null;
  }

  @override
  toJson() {
    return {
      "ong_id": ong.id,
      "shipping_method": type.name,
      "address_id": _userAddress!.id,
      "range_time_id": _rangeId,
      "weekday_id": _weekdayId,
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
