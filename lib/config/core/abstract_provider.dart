import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../util/http/http_exception.dart';
import '../../util/http/http_manager.dart';

abstract class AbstractProvider<E> {
  AbstractProvider(
    this._path,
    this._tag, {
    this.baseUrl,
    this.isAuth = false,
  }) {
    _client = HttpManager(
      tag: _tag,
      baseUrl: baseUrl,
      isAuth: isAuth,
    ).client;
  }
  final String _path;
  final String _tag;
  final String? baseUrl;
  final bool isAuth;
  late Dio _client;

  Future<Response<dynamic>> get({
    String innerPath = '',
    CancelToken? cancelToken,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) async {
    try {
      final Response<dynamic> response = await _client.get(
        '/$_path/$innerPath',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> post(E entity, {String innerPath = ''}) async {
    try {
      final Response<dynamic> response =
          await _client.post<E>('/$_path/$innerPath', data: entity);
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> postCustom({
    String innerPath = '',
    CancelToken? cancelToken,
    @required dynamic data,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Options? options,
  }) async {
    assert(data != null);
    try {
      final Response<dynamic> response = await _client.post(
        '/$_path/$innerPath',
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> put({
    required E data,
    String innerPath = '',
    CancelToken? cancelToken,
    Map<String, String> queryParameters = const <String, String>{},
  }) async {
    try {
      final Response<dynamic> response = await _client.put(
        '/$_path/$innerPath',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> delete({
    String innerPath = '',
    CancelToken? cancelToken,
    Map<String, String> queryParameters = const <String, String>{},
  }) async {
    try {
      final Response<dynamic> response = await _client.delete(
        '/$_path/$innerPath',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  void throwIfNoSuccess(Response<dynamic> response) {
    if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 299) {
      throw HttpException(response);
    }
  }
}
