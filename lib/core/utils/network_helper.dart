import 'package:dio/dio.dart';
import 'package:edustar/core/exceptions/decode_exception.dart';

import '../../core/exceptions/network_exception.dart';
import '../../core/models/base.dart';

void checkForNetworkExceptions(Response response) {
  final base = decodeResponseBodyToBase(response.data);
  if (!base.success) {
    throw NetworkException(base.message);
  }
}

Base decodeResponseBodyToBase(Map<String, dynamic> body) {
  try {
    return Base.fromJson(body);
  } on FormatException catch (e) {
    print('Failed to decode response body');
    throw DecodeException(e.message);
  }
}