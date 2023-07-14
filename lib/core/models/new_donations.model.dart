import 'package:microdonations/core/models/donation_item.model.dart';

class NewDonation {
  Map<DonationItem, int>? _donationsList;

  NewDonation({
    Map<DonationItem, int>? donationsList,
  }) : _donationsList = donationsList;

  /// Setea la lista de items [_donationList] que se van
  /// a donar junto con su cantidad
  set donationList(Map<DonationItem, int> data) => _donationsList = data;
}
