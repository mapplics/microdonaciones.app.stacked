import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class ReceptionApiService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Devuelve los puntos de entrega de la [ong].
  Future<List<ReceptionPoint>> getReceptionPoints(Ong ong) async {
    try {
      final response = await _dio.get(
        '${_apiUrl}reception-points/${ong.id}',
        options: Options(responseType: ResponseType.json),
      );

      return ReceptionPoint.createList(response.data['data']);
    } catch (e) {
      logError('No se pudo recuperar los puntos de entrega! ${e.toString()}');
      rethrow;
    }
  }

  /// Devuelve los los horarios de retiro a domicilio que puede hacer la [ong].
  Future<List<ReceptionPoint>> getWeekdayRangeTime(Ong ong) async {
    try {
      final response = await _dio.get(
        '${_apiUrl}pickeup-weekday-range-time/${ong.id}',
        options: Options(responseType: ResponseType.json),
      );

      return ReceptionPoint.createList(response.data['data']);
    } catch (e) {
      logError('No se pudo recuperar los puntos de entrega! ${e.toString()}');
      rethrow;
    }
  }
}
