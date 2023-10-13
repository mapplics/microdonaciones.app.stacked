import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/delivery_history_order.model.dart';
import 'package:microdonations/core/models/pickup_history_order.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class OrderHistoryDetailViewModel extends BaseViewModel {
  final BaseHistoryOrder orderHistory;

  OrderHistoryDetailViewModel(this.orderHistory);

  /// Devuelve el historial de ordenes.
  BaseHistoryOrder get order => orderHistory;

  /// Devuelve el historial de ordenes.
  DeliveryHistoryOrder? get deliveryOrder {
    if (ShippingMethod.delivery == orderHistory.shippingMethod) {
      return orderHistory as DeliveryHistoryOrder;
    } else {
      return null;
    }
  }

  PickupHistoryOrder? get pickupDonation {
    if (ShippingMethod.pickup == orderHistory.shippingMethod) {
      return orderHistory as PickupHistoryOrder;
    } else {
      return null;
    }
  }

  String get pickupTimeDetail {
    if (pickupDonation != null) {
      return 'El día ${pickupDonation!.weekday.name} ${DateTimeHelper.formatDateTime(pickupDonation!.pickupDate)} entre las ${pickupDonation!.range.betweenTime}.';
    } else {
      return 'Dato Invalido';
    }
  }
}
