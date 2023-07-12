// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

import '../../app/app.locator.dart';
import '../exceptions/http_exception.model.dart';
import '../exceptions/no_internet_exception.model.dart';

class DioClient {
  final _authService = locator<AuthService>;

  static final DioClient _instance = DioClient._privateConstructor();

  static final Dio _dio = Dio();

  /// Singleton wrapper del cliente http.
  ///
  /// Permite compartir una unica instancia de Dio en toda la app con la misma
  /// configuración e interceptors seteados.
  ///
  /// Ejemplo de uso en los providers:
  ///   final dio = DioClient().dio;
  DioClient._privateConstructor() {
    _setAuthInterceptor();
    _setRetryInterceptor();
  }

  factory DioClient() => _instance;

  Dio get dio => _dio;

  /// Devuelve true si el error es por falta de internet
  static bool isConnectionError(DioException e) {
    if (e.message!.contains('SocketException')) {
      return true;
    }

    switch (e.type) {
      case DioExceptionType.badResponse:
        return false;
      case DioExceptionType.cancel:
        return false;
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        return true;
    }
  }

  static dynamic parseDioException(DioException e) {
    if (isConnectionError(e)) {
      return NoInternetException(e.message!);
    }

    return HttpException(e.message!, response: e.response);
  }

  /// Agrega auth token a la request, desloguea si llega un 403/401
  void _setAuthInterceptor() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Do something before request is sent

          try {
            if (_authService.call().isUserLogged) {
              options.headers['Authorization'] =
                  _authService.call().authModel!.bearer;
            }
          } catch (e) {
            logError('<Interceptor> ${e.toString()}');
            await _authService.call().logout();
          }

          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onError: (DioException e, handler) async {
          if (e.response != null && e.response?.statusCode == 403 ||
              e.response?.statusCode == 401) {
            /// Si la request que devolvió 403 es la de traducciones no hago el logout
            /// esto puede pasar cuando usamos las trads de develop en drive
            /// drive aveces devuelve 403 al solicitar las traducciones
            /// en la api de ch no "debería" suceder nunca
            await _authService.call().logout();
          }

          return handler.next(e);
        },
      ),
    ]);
  }

  /// Reintenta las request que fallan
  void _setRetryInterceptor() {
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
        ],
      ),
    );
  }
}
