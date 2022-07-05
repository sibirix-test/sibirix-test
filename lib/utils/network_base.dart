import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fwitter/utils/globals.dart';

abstract class NetworkBase {
  @visibleForOverriding
  CacheOptions? get cacheOptions => null;

  @visibleForOverriding
  String get baseUrl => AppConfig.baseApiUrl;

  @mustCallSuper
  Map<String, String> get defaultHeaders => {};

  @mustCallSuper
  Map<String, String> get defaultQuery => {};

  int get sendTimeout => 3000;
  int get connectTimeout => 3000;
  int get recieveTimeout => 15000;

  Dio? _dio;
  Dio _buildDioInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: defaultHeaders,
        queryParameters: defaultQuery,
        sendTimeout: sendTimeout,
        connectTimeout: connectTimeout,
        receiveTimeout: recieveTimeout,
      ),
    );
    dio.interceptors.addAll([
      RetryInterceptor(
        dio: dio,
        retries: 3,
        retryDelays: [
          const Duration(milliseconds: 1300),
          const Duration(milliseconds: 5000),
        ],
      ),
      if (cacheOptions != null) DioCacheInterceptor(options: cacheOptions!),
    ]);

    return dio;
  }

  @nonVirtual
  Dio get dio => _dio ??= _buildDioInstance();
}
