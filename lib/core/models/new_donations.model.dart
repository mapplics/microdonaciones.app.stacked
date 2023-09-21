import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:collection/collection.dart';

import 'pickup_dropdown_value.model.dart';

class NewDonation {
  final Ong ong;
  final List<DonationItem> _donationsList = [];

  NewDonation({required this.ong});

  TypeDelivery typeDelivery = TypeDelivery.dropoff;
  UserAddress? _userAddress;
  PickupDropdownValue? _pickupValue;
  ReceptionPoint? _receptionPoint;

  /// Devuelve la lista de items [DonationItem] que el usuario selecciono
  /// para donar.
  List<DonationItem> get donationsItemsList => _donationsList;

  /// Recibe un [DonationItem] y lo agrega a [_donationsList]
  void addDonationItem(DonationItem donationItem) {
    _donationsList.add(donationItem);
  }

  /// Recibe un [Product] que se utiliza para buscar una
  /// coincidencia en [_donationsList] si se encuentra una coincidencia
  /// se elimina de la lista de [_donationsList]
  void removeDonationItem(Product product) {
    final _index = _donationsList.indexWhere(
      (selectedItem) => selectedItem.product.id == product.id,
    );

    _donationsList.removeAt(_index);
  }

  /// Actualiza el tipo de delivery [TypeDelivery] de la donacion
  void updateTypeDelivery(TypeDelivery type) => typeDelivery = type;

  /// Setea el [_userAddress].
  /// Se utiliza cuando la donacion se retira por la casa del donante.
  set userAddress(UserAddress userAddress) => _userAddress = userAddress;

  UserAddress? get userAddressValue => _userAddress;

  /// Resetea [_userAddress] a null.
  void resetUserAddress() => _userAddress = null;

  /// Setea el [_pickupValue].
  /// Se utiliza cuando la donacion se retira por la casa del donante.
  set setPickupValue(PickupDropdownValue pickupValue) =>
      _pickupValue = pickupValue;

  /// Devuelve [_pickupValue]
  PickupDropdownValue? get pickupValue => _pickupValue;

  /// Resetea [_pickupValue] a null.
  void resetPickupValue() => _pickupValue = null;

  /// Setea el [_receptionPoint].
  /// Se utiliza cuando la donacion la lleva el donante a un punto de entrega.
  set receptionPoint(ReceptionPoint receptionPoint) =>
      _receptionPoint = receptionPoint;

  /// Resetea [_receptionPoint] a null.
  void resetReceptionPoint() => _receptionPoint = null;

  ReceptionPoint? get receptionPointValue => _receptionPoint;

  /// Recibe un [DonationItem] y la cantidad [quantity] que se le va a setear
  /// al mismo [DonationItem].
  void updateDonationItemQuality(DonationItem item, int quantity) {
    final _found = donationsItemsList.firstWhereOrNull(
      (selectedItem) => selectedItem.title == item.title,
    );

    /// Chequeo si encontre el item que quiero modificar
    if (_found != null) {
      _found.updateQuantity = quantity;
    } else {
      logError('DonationItem not found!');
    }
  }

  /// Devuelve true si existe un [DonationItem]
  /// en [_donationsList] para el [product].
  bool checkIfItemExist(Product product) {
    final _found = donationsItemsList.firstWhereOrNull(
        (selectedItem) => selectedItem.product.id == product.id);

    return (_found != null);
  }

  /// Devuelve true si el metodo de entrega de la donacion es a domicilio.
  bool get _isDelivery => (TypeDelivery.delivery == typeDelivery);

  toJson() {
    return {
      "ong_id": ong.id,
      "shipping_method": typeDelivery.name,
      "reception_point_id": _receptionPoint?.id,
      "address_id": _isDelivery ? _userAddress!.id : null,
      "range_time_id": _isDelivery ? _pickupValue!.rangeTimeId : null,
      "weekday_id": _isDelivery ? _pickupValue!.weekdayId : null,
      "products": _donationsList
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
