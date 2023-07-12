import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/logged_user.model.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../core/interceptor/dio.interceptor.dart';

class UserApiService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Recibe una request [UpdateUserRequest] para actualizar los datos
  /// personales del usuario logueado.
  Future<LoggedUser> updateUser(UpdateUserRequest updateUserRequest) async {
    try {
      final response = await _dio.put(
        '${_apiUrl}customers/update-me',
        data: updateUserRequest.toJson(),
        options: Options(responseType: ResponseType.json),
      );

      return LoggedUser.createOne(response.data['data']);
    } catch (e) {
      logError('No se pudo actualizar el usuario! ${e.toString()}');
      rethrow;
    }
  }
}
