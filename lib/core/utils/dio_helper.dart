import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioHelper {
  static Dio getDio(String url) {
    final dio = Dio(BaseOptions(baseUrl: url, contentType: 'application/json'))
      ..interceptors.add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor)
      ..interceptors.add(LogInterceptor(responseBody: true));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }
}
