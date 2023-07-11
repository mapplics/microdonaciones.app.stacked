import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/update_user_request.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../interceptor/dio.interceptor.dart';
import '../models/logged_user.model.dart';

class UserService {
  final dio = DioClient().dio;

  String? apiUrl = dotenv.env['API_URL'];

  late LoggedUser _loggedUser;

  void set(LoggedUser user) => _loggedUser = user;

  LoggedUser get loggedUser => _loggedUser;

  Future<void> updateUser(UpdateUserRequest updateUserRequest) async {
    try {
      final response = await dio.put(
        '${apiUrl}social-login',
        data: updateUserRequest.toJson(),
        options: Options(
          responseType: ResponseType.json,
        ),
      );
    } catch (e) {
      logError('No se pudo actualizar el usuario! ${e.toString()}');
    }
  }
}
