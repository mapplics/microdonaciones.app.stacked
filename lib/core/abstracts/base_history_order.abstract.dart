import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/order_state.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

abstract class BaseHistoryOrder {
  final int orderId;
  final ShippingMethod shippingMethod;
  final OrderState orderState;
  final List<DonationItem> products;
  final DateTime createAt;

  BaseHistoryOrder({
    required this.orderId,
    required this.shippingMethod,
    required this.orderState,
    required this.products,
    required this.createAt,
  });
}
