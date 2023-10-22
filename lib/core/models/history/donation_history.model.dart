import 'package:microdonations/core/models/history/order_state.model.dart';
import 'package:microdonations/core/models/ong/ong_product.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

class DonationHistory {
  final int id;
  final ShippingMethod shippingMethod;
  final OngReceptionPoint? receptionPoint;
  final RangeTime? rangeTime;
  final String? weekday;
  final OrderState orderState;
  final List<OngProduct> products;

  DonationHistory({
    required this.id,
    required this.shippingMethod,
    required this.receptionPoint,
    required this.rangeTime,
    required this.weekday,
    required this.orderState,
    required this.products,
  });

  static DonationHistory createOne(Map<String, dynamic> data) {
    return DonationHistory(
      id: data['id'],
      shippingMethod: _parseTypeDelivery(data['shippingMethod']),
      receptionPoint: OngReceptionPoint.createOne(data['receptionPoint']),
      rangeTime: null,
      weekday: null,
      orderState: OrderState.createOne(data['orderState']),
      products: OngProduct.createList(data['products']),
    );
  }

  static ShippingMethod _parseTypeDelivery(type) {
    switch (type) {
      case 'pickup':
        return ShippingMethod.pickup;
      case 'delivery':
        return ShippingMethod.delivery;
      default:
        return ShippingMethod.unknow;
    }
  }
}
