// ignore_for_file: avoid_init_to_null

import 'package:microdonations/core/models/new_donation/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/new_donation/donation_product_list.model.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/user/user_address.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

/// Representa una donacion que va a hacer el usuario
/// y que se le va a retirar a domicilio.
class PickupDonation extends BaseNewDonation {
  late RangeTime? _rangeTime = null;
  late DateTime? _pickupDate = null;
  late UserAddress? _userAddress = null;
  late String? _observations = null;

  PickupDonation({super.type = ShippingMethod.pickup});

  @override
  set setDonationItemsDetail(DonationProductList items) {
    donationItemsDetail = items;
  }

  @override
  set setOng(Ong selectedOng) {
    ong = selectedOng;
  }

  set setRangeTime(RangeTime rangeTime) {
    _rangeTime = rangeTime;
  }

  RangeTime? get rangeTime => _rangeTime;

  set setPickupDate(DateTime date) {
    _pickupDate = date;
  }

  String? get observations => _observations;

  set setObservations(String observations) {
    _observations = observations;
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
    return (_rangeTime != null) &&
        (_pickupDate != null) &&
        (_userAddress != null);
  }

  /// Resetea todos los campos.
  void resetFields() {
    _rangeTime = null;
    _pickupDate = null;
    _userAddress = null;
  }

  String _formatearNumero(int day) {
    return (day < 10) ? '0$day' : day.toString();
  }

  @override
  toJson() {
    return {
      "ong_id": ong.id,
      "shipping_method": 'pickup',
      "address_id": _userAddress!.id,
      "range_time_id": _rangeTime!.id,
      "observations": _observations,
      "date":
          '${_pickupDate!.year}${_pickupDate!.month}${_formatearNumero(_pickupDate!.day)}',
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
