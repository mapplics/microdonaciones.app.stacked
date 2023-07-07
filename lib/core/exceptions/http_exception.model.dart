import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String message;
  final Response<dynamic>? response;

  HttpException(this.message, {this.response});

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
