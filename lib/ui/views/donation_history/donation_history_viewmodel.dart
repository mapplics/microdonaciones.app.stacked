import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/services/order_history_service.dart';
import 'package:stacked/stacked.dart';

class DonationHistoryViewModel extends BaseViewModel {
  final _orderHistoryService = locator<OrderHistoryService>();
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
}
