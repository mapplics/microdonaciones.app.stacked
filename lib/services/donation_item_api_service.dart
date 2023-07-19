import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/donation_item_presentation.model.dart';
import 'package:microdonations/core/models/ong.model.dart';

class DonationItemApiService {
  final _dio = DioClient().dio;
  final String? _apiUrl = dotenv.env['API_URL'];

  /// Devuelve la lista de items que se puede donar para una ONG
  Future<List<DonationItemPresentation>> getDonationItems(Ong ong) async {
    try {
      final _response = await _dio.get(
        '${_apiUrl}product-by-ong/${ong.id}',
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return DonationItemPresentation.createList(_response.data);
    } catch (e) {
      rethrow;
    }
  }
}
