import 'package:microdonations/core/models/history/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/new_donation/donation_product.model.dart';
import 'package:microdonations/core/models/history/order_state.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

/// Representa en el historial una donacion por delivery que hizo el usuario
class DeliveryHistoryOrder extends BaseHistoryOrder {
  final OngReceptionPoint receptionPoint;

  DeliveryHistoryOrder({
    required this.receptionPoint,
    required super.orderId,
    required super.orderState,
    required super.products,
    required super.createAt,
    super.shippingMethod = ShippingMethod.delivery,
  });

  static DeliveryHistoryOrder createOne(Map<String, dynamic> data) {
    return DeliveryHistoryOrder(
        orderId: data['id'],
        products: DonationProduct.createArray(data['products']),
        receptionPoint: OngReceptionPoint.createOne(data['receptionPoint']),
        orderState: OrderState.createOne(data['orderState']),
        createAt: DateTime.parse(data['createdAt']));
  }
}
