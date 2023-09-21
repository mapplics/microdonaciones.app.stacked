import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/abstracts/base_new_donation.abstract.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/new_donations.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class NewDonationApiService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Recibe un [NewDonation] y crea una donacion.
  Future<void> createDonation(BaseNewDonation donation) async {
    try {
      await _dio.post(
        '${_apiUrl}orders',
        data: donation.toJson(),
        options: Options(responseType: ResponseType.json),
      );
    } catch (e) {
      logError('No se pudo crear la donacion! ${e.toString()}');
      rethrow;
    }
  }
}
