import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/product.model.dart';
import 'package:microdonations/core/models/ong.model.dart';

class DonationItemApiService {
  final _dio = DioClient().dio;
  final String? _apiUrl = dotenv.env['API_URL'];

  /// Devuelve la lista de productos [Product] que se puede donar una ONG
  Future<List<Product>> getProductsByOng(Ong ong) async {
    try {
      final _response = await _dio.get(
        '${_apiUrl}product-by-ong/${ong.id}',
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return Product.createList(_response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
