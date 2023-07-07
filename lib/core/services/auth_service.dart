import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/auth.model.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../../ui/common/helpers/storage.helpers.dart';
import '../interceptor/dio.interceptor.dart';

class AuthService {
  final dio = DioClient().dio;

  String? apiUrl = dotenv.env['API_URL'];

  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => (_authModel != null);

  /// Setea el [AuthModel] del usuario.
  void setAuthModel(String token) => _authModel = AuthModel(token: token);

  /// Devuelve el token del Google del [_authModel]
  get authToken => _authModel?.token ?? 'token-not-found';

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  /// Intenta recuperar un [AuthModel] del storage.
  void tryAutoLogin() => _authModel = StorageHelper.getAuthModel();

  /// Login para el usuario.
  /// Envia el email y el token de Google.
  Future<void> login(String email, String token) async {
    try {
      final response = await dio.post(
        'http://10.0.2.2:8080/api/v1/social-login',
        data: {
          'email': email,
          'token': token,
        },
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      setAuthModel(response.data['data']['token']);

      logSucess(_authModel?.bearer ?? 'No disponible');
    } on DioException catch (e) {
      throw DioClient.parseDioException(e);
    }
  }

  /// Hace el logout del usuario. Setea [_authoModel] en null
  /// y limpia el cache de la app.
  Future<void> logout() async {
    _authModel = null;
    await StorageHelper.logoutClean();
  }
}
