import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../interceptor/dio.interceptor.dart';
import '../models/logged_user.model.dart';

class UserService {
  final _dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  late LoggedUser _loggedUser;

  set setLoggedUser(LoggedUser user) => _loggedUser = user;

  LoggedUser get loggedUser => _loggedUser;

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
