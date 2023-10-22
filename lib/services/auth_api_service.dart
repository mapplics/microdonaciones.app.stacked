import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/user/social_login_response.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class AuthApiService {
  final dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Login para el usuario.
  /// Envia el email y el token de Google.
  Future<SocialLoginResponse> login(String email, String token) async {
    try {
      logWarn('${_apiUrl}social-login');
      final response = await dio.post(
        '${_apiUrl}social-login',
        data: {
          'email': email,
          'token': token,
        },
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      /// Parseo la respuesta de la API.
      final socialLoginResp = SocialLoginResponse.createOne(
        response.data['data'],
      );

      return socialLoginResp;
    } on DioException catch (e) {
      throw DioClient.parseDioException(e);
    }
  }
}
