import 'package:dio/dio.dart';

class HttpException implements Exception {
  HttpException(
    this.response,
  );
  Response<dynamic> response;
  @override
  String toString() {
    return 'HttpException{response: $response}';
  }

  static String handleError(Object error) {
    String errorDescription = '';
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.sendTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.receiveTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.response:
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          // TODO: Handle this case.
          break;
      }
    } else {
      errorDescription = 'kUnexpectedError';
    }
    return errorDescription;
  }
}
