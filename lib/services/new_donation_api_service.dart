import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/new_donation/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class NewDonationApiService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Recibe un [BaseNewDonation] y crea una donacion.
  Future<void> createDonation(BaseNewDonation donation) async {
    try {
      final json = donation.toJson();

      await _dio.post(
        '${_apiUrl}orders',
        data: json,
        options: Options(responseType: ResponseType.json),
      );
    } catch (e) {
      logError('No se pudo crear la donacion! ${e.toString()}');
      rethrow;
    }
  }
}
