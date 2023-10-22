import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/history/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/services/order_history_service.dart';
import 'package:stacked/stacked.dart';

class OrdersHistoryViewModel extends BaseViewModel {
  final _orderHistoryService = locator<OrderHistoryService>();

  final PagingController<int, BaseHistoryOrder> pagingController =
      PagingController(firstPageKey: 0);

  /// Inicializa el paging controller.
  init() {
    pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  /// Trae una nueva pagina de donaciones.
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

  /// Vuelva a cargar el historial de donaciones.
  Future<void> refresHistoy() async {
    await Future.sync(() => pagingController.refresh());
  }

  /// Recuper el historial de donaciones.
  Future<List<BaseHistoryOrder>> getHistory(int pageNumber) async {
    try {
      return await _orderHistoryService.getOrdersHistory(pageNumber);
    } catch (e) {
      rethrow;
    } finally {
      rebuildUi();
    }
  }
}
