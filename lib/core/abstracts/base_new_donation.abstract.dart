// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:microdonations/core/models/donation_items_detail.model.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

abstract class BaseNewDonation {
  late Ong ong;
  late DonationItemsDetail donationItemsDetail;
  ShippingMethod type;

  BaseNewDonation({required this.type});

  /// Setea la ONG que recibe la donación
  set setOng(Ong ong);

  /// Setea los productos que se van a donar.
  set setDonationItemsDetail(DonationItemsDetail items);

  /// Devuelve un JSON para enviar a la API
  /// y crear una donación.
  Object toJson();
}
