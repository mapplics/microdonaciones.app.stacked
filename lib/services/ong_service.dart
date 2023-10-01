import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class OngService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Devuelve una lista de ongs disponibles.
  Future<List<Ong>> getOngs() async {
    try {
      final response = await _dio.get(
        '${_apiUrl}ongs?filter[enabled]=1',
        options: Options(responseType: ResponseType.json),
      );

      return Ong.createArray(response.data['data']);
    } catch (e) {
      logError('No se pudo recuperar la lista de ongs! ${e.toString()}');
      rethrow;
    }
  }
}
