import 'dart:io';

abstract class HttpBase {
  /// Send GET request to endpoint /[route] and return the `response`
  /// - success: Returns decoded json data
  ///
  /// - failed: throws `NetworkException`
  Future<dynamic> getHttp(String route);

  /// Send POST request with [body] to endpoint /[route] and return the `response`
  /// - success: Returns decoded json data
  ///
  /// - failed: throws `NetworkException`
  Future<dynamic> postHttp(String route, dynamic body);

  /// Send POST request with [files] to endpoint /[route] and return the `response`
  /// - success: Returns decoded json data
  ///
  /// - failed: throws `NetworkException`
  Future<dynamic> postHttpForm(String route, Map<String, dynamic> body, List<File> files);

  /// Download file from [fileUrl] and return the file
  /// - success: Returns the file.
  ///
  /// - failed: throws `NetworkException`
  Future<File> downloadFile(String fileUrl, String subDirectory);

  /// Send DELETE request with [body] to endpoint /[route] and return the `response`
  /// - success: Returns decoded json data
  ///
  /// - failed: throws `NetworkException`
  Future<dynamic> deleteHttp(String route, dynamic body);

  void dispose();
}
