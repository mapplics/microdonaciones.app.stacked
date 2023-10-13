import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/ui/views/order_history_detail/order_history_detail_view.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderHistoryTileModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool isDeliveryOrder(BaseHistoryOrder order) {
    return order.shippingMethod == ShippingMethod.delivery;
  }

  void showOrderDetail(BaseHistoryOrder historyOrder) {
    _navigationService.navigateToOrderHistoryDetailView(
      viewParameters: OrderHistoryDetailParameters(historyOrder),
    );
  }
}
