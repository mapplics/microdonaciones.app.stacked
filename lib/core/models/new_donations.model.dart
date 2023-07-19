import 'package:microdonations/core/models/donation_item.model.dart';

class NewDonation {
  List<DonationItem> donationsList;

  NewDonation({
    required this.donationsList,
  }) : assert(
          donationsList.isNotEmpty,
          'DonationList should not be empty',
        );
}
