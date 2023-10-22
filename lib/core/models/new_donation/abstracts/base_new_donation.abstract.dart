// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:microdonations/core/models/new_donation/donation_product_list.model.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

abstract class BaseNewDonation {
  late Ong ong;
  late DonationProductList donationItemsDetail;
  ShippingMethod type;

  BaseNewDonation({required this.type});

  /// Setea la ONG que recibe la donación
  set setOng(Ong ong);

  /// Setea los productos que se van a donar.
  set setDonationItemsDetail(DonationProductList items);

  /// Devuelve un JSON para enviar a la API
  /// y crear una donación.
  Object toJson();
}
