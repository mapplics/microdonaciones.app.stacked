import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/delivery_history_order.model.dart';
import 'package:microdonations/core/models/pickup_history_order.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class OrderHistoryDetailViewModel extends BaseViewModel {
  final BaseHistoryOrder orderHistory;

  OrderHistoryDetailViewModel(this.orderHistory);

  BaseHistoryOrder get order => orderHistory;

  DeliveryHistoryOrder? get deliveryOrder {
    if (TypeDelivery.delivery == orderHistory.shippingMethod) {
      return orderHistory as DeliveryHistoryOrder;
    } else {
      return null;
    }
  }

  PickupHistoryOrder? get pickupDonation {
    if (TypeDelivery.dropoff == orderHistory.shippingMethod) {
      return orderHistory as PickupHistoryOrder;
    } else {
      return null;
    }
  }
}