import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:microdonations/core/models/history/order_state.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

/// Campos basicos que tiene todo historial de donación.
abstract class BaseHistoryOrder {
  final int orderId;
  final ShippingMethod shippingMethod;
  final OrderState orderState;
  final List<DonationProduct> products;
  final DateTime createAt;

  BaseHistoryOrder({
    required this.orderId,
    required this.shippingMethod,
    required this.orderState,
    required this.products,
    required this.createAt,
  });
}
