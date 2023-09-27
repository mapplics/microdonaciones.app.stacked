import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/models/order_state.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/weekday.model.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

/// Representa en el historial una donacion que le retiraron al usuario
class PickupHistoryOrder extends BaseHistoryOrder {
  final String address;
  final RangeTime range;
  final Weekday weekday;

  PickupHistoryOrder({
    required this.address,
    required this.range,
    required this.weekday,
    required super.orderId,
    required super.orderState,
    required super.products,
    required super.createAt,
    super.shippingMethod = TypeDelivery.dropoff,
  });

  static PickupHistoryOrder createOne(Map<String, dynamic> data) {
    return PickupHistoryOrder(
        orderId: data['id'],
        address: data['address'],
        products: DonationItem.createArray(data['products']),
        range: RangeTime.createOne(data['rangeTime']),
        orderState: OrderState.createOne(data['orderState']),
        weekday: Weekday.createOne(data['weekday']),
        createAt: DateTime.parse(data['createdAt']));
  }
}
