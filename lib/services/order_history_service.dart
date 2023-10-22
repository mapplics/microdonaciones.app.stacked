import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/history/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/history/delivery_history_order.model.dart';
import 'package:microdonations/core/models/history/pickup_history_order.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';

class OrderHistoryService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  static const pageSize = 10;

  /// Devuelve los puntos de entrega de la [ong].
  Future<List<BaseHistoryOrder>> getOrdersHistory(int pageNumber) async {
    try {
      final response = await _dio.get(
        '${_apiUrl}orders-history?page[number]=$pageNumber&page[size]=$pageSize&include=orderState,receptionPoint,rangeTime,weekday,products',
        options: Options(responseType: ResponseType.json),
      );

      final List<BaseHistoryOrder> ordersHistory = [];
      final dataList = response.data['data'] as List<dynamic>;

      for (var element in dataList) {
        final order = element['shippingMethod'] == ShippingMethod.delivery.name
            ? DeliveryHistoryOrder.createOne(element)
            : PickupHistoryOrder.createOne(element);

        ordersHistory.add(order);
      }

      /// Ordeno las clases por fecha.
      ordersHistory.sort((a, b) => b.createAt.compareTo(a.createAt));

      return ordersHistory;
    } catch (e) {
      logError('No se pudo recuperar el historial de ordenes! ${e.toString()}');
      rethrow;
    }
  }
}
