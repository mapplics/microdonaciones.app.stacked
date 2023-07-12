import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdonations/core/models/auth.model.dart';
import 'package:microdonations/core/models/social_login_response.model.dart';

import '../../ui/common/helpers/storage.helpers.dart';
import '../core/interceptor/dio.interceptor.dart';

class AuthService {
  final dio = DioClient().dio;

  final String? _apiUrl = dotenv.env['API_URL'];

  /// Modelo que contiene el token del usuario logueado.
  AuthModel? _authModel;

  /// Devuelve true si el usuario esta logueado.
  bool get isUserLogged => (_authModel != null);

  /// Setea el [AuthModel] del usuario.
  void setAuthModel(String token) => (_authModel = AuthModel(token: token));

  /// Devuelve el token del Google del [_authModel]
  get authToken => _authModel?.token ?? 'token-not-found';

  /// Devuelve el [AuthModel].
  AuthModel? get authModel => _authModel;

  /// Intenta recuperar un [AuthModel] del storage.
  void tryAutoLogin() => _authModel = StorageHelper.getAuthModel();

  /// Login para el usuario.
  /// Envia el email y el token de Google.
  Future<SocialLoginResponse> login(String email, String token) async {
    try {
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

      setAuthModel(socialLoginResp.token);

      return socialLoginResp;
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
