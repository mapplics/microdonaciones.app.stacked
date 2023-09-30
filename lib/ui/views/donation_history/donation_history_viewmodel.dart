import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/services/order_history_service.dart';
import 'package:stacked/stacked.dart';

class DonationHistoryViewModel extends BaseViewModel {
  final _orderHistoryService = locator<OrderHistoryService>();
  bool haveError = false;
  bool isLoading = false;
  // List<BaseHistoryOrder> ordersHistory = [];

  final PagingController<int, BaseHistoryOrder> pagingController =
      PagingController(firstPageKey: 0);

  init() {
    pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  /// Trae una nueva pagina de notificaciones.
  Future<void> _fetchPage(int pageKey) async {
    try {
      final ordersHistory = await getHistory(pageKey);

      final isLastPage = ordersHistory.length < OrderHistoryService.pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(ordersHistory);
      } else {
        final nextPageKey = pageKey + ordersHistory.length;
        pagingController.appendPage(ordersHistory, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refresHistoy() async {
    await Future.sync(() => pagingController.refresh());
  }

  /// Recuper el historial de donaciones.
  Future<List<BaseHistoryOrder>> getHistory(int pageNumber) async {
    try {
      isLoading = true;

      rebuildUi();

      return await _orderHistoryService.getOrdersHistory(pageNumber);
    } catch (e) {
      haveError = true;
      return [];
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }
}
