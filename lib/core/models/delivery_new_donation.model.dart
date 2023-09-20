import 'package:microdonations/core/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

import 'user_address.model.dart';

class DeliveryNewDonation extends BaseNewDonation {
  int? _weekdayId;
  int? _rangeId;
  DateTime? _pickupDate;
  UserAddress? _userAddress;

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

  DateTime? get pickupDate => _pickupDate;

  set setUserAddress(UserAddress userAddress) {
    _userAddress = userAddress;
  }

  UserAddress? get userAddress => _userAddress;

  bool valid() {
    return (_weekdayId != null) && (_rangeId != null) && (_pickupDate != null);
  }
}
