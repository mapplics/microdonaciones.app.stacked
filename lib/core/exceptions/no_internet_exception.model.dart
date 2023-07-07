class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
