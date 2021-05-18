import 'package:dio/dio.dart';
import '../../config/constant/app_config.dart';
import '../log/dio_logger.dart';

class HttpManager {
  HttpManager({required this.tag, this.baseUrl, required this.isAuth}) {
    _dio.options.baseUrl = baseUrl ?? AppConfig.baseUrl;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {
        if (!isAuth) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['cookie'] = cookie;
          }
        }
        DioLogger.onSend(tag, options);
        return handler.next(options);
      },
      onResponse: (Response<dynamic> response, handler) {
        DioLogger.onSuccess(tag, response);
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        DioLogger.onError(tag, error);
        return handler.next(error);
      },
    ));
  }

  static String? token;
  static String? cookie;
  // static User user;
  final String tag;
  final String? baseUrl;
  final bool isAuth;

  final Dio _dio = Dio();
  Dio get client => _dio;
}
