import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/services/order_history_service.dart';
import 'package:microdonations/ui/views/order_history_detail/order_history_detail_view.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonationHistoryViewModel extends BaseViewModel {
  final _orderHistoryService = locator<OrderHistoryService>();
  final _navigationService = locator<NavigationService>();

  bool haveError = false;
  bool isLoading = false;
  List<BaseHistoryOrder> ordersHistory = [];

  /// Recuper el historial de donaciones.
  Future<void> getHistory() async {
    try {
      isLoading = true;

      rebuildUi();

      ordersHistory = await _orderHistoryService.getOrdersHistory();
    } catch (e) {
      haveError = true;
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }

  bool isDeliveryOrder(BaseHistoryOrder order) {
    return order.shippingMethod == TypeDelivery.delivery;
  }

  void showOrderDetail(BaseHistoryOrder historyOrder) {
    _navigationService.navigateToOrderHistoryDetailView(
      viewParameters: OrderHistoryDetailParameters(historyOrder),
    );
  }
}
