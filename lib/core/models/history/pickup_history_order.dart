import 'package:microdonations/core/models/history/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:microdonations/core/models/history/order_state.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

/// Representa el historial de una donacion
/// que se le retiro a domicilio al usuario.
class PickupHistoryOrder extends BaseHistoryOrder {
  final String address;
  final RangeTime range;
  final DateTime pickupDate;
  final String? observations;

  PickupHistoryOrder({
    required this.address,
    required this.range,
    required this.pickupDate,
    required super.orderId,
    required super.orderState,
    required super.products,
    required super.createAt,
    super.shippingMethod = ShippingMethod.pickup,
    this.observations,
  });

  static PickupHistoryOrder createOne(Map<String, dynamic> data) {
    return PickupHistoryOrder(
      orderId: data['id'],
      address: data['address'],
      products: DonationProduct.createArray(data['products']),
      range: RangeTime.createOne(data['rangeTime']),
      orderState: OrderState.createOne(data['orderState']),
      createAt: DateTime.parse(data['createdAt']),
      pickupDate: DateTime.parse(data['date']),
      observations: data['observations'],
    );
  }
}
