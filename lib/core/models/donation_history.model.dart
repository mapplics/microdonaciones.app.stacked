import 'package:microdonations/core/models/order_state.model.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/widgets/new_donation/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';

class DonationHistory {
  final int id;
  final ShippingMethod shippingMethod;
  final ReceptionPoint? receptionPoint;
  final RangeTime? rangeTime;
  final String? weekday;
  final OrderState orderState;
  final List<Product> products;

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
      receptionPoint: ReceptionPoint.createOne(data['receptionPoint']),
      rangeTime: null,
      weekday: null,
      orderState: OrderState.createOne(data['orderState']),
      products: Product.createList(data['products']),
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
