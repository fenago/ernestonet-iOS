import 'dart:io';

import 'package:dio/dio.dart';

import '../../../locator.dart';
import '../../constants/api_routes.dart';
import '../../services/http/http_base.dart';
import '../../utils/dio_helper.dart';
import '../../utils/file_helper.dart';
import '../../utils/network_helper.dart' as network_helper;

class ApiService implements HttpBase {
  final _fileHelper = locator<FileHelper>();

  Dio _dio;

  @override
  Future<dynamic> getHttp(String route) async {
    Response response;
    try {
      final url = '${ApiRoutes.baseUrl}$route';
      _dio = DioHelper.getDio(url);

      response = await _dio.get(
        url,
      );
    } on DioError catch (e) {
      print('Dio get request error : ${e.message}');
      network_helper.checkForNetworkExceptions(e.response);
    }
    network_helper.checkForNetworkExceptions(response);
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, dynamic body) async {
    Response response;
    try {
      final url = '${ApiRoutes.baseUrl}$route';
      print('POST HTTP URL : $url');
      print('body : $body');
      _dio = DioHelper.getDio(url);

      response = await _dio.post(
        url,
        data: body,
      );
      print('My Response : $response');
    } on DioError catch (e) {
      network_helper.checkForNetworkExceptions(e.response);
    }
    network_helper.checkForNetworkExceptions(response);
    return response.data;
  }

  @override
  Future<dynamic> postHttpForm(String route, Map<String, dynamic> body, List<File> files) async {
    final url = '${ApiRoutes.baseUrl}$route';
    print('POST HTTP FORM URL : $url');
    print('body : $body');
    final formData = FormData.fromMap(body);
    if (files[0] != null && files.length > 0) {
      String fileName = files[0].path.split('/').last;
      final multipartFile = await MultipartFile.fromFile(files[0].path, filename: fileName);
      formData.files.add(MapEntry('user_img', multipartFile));
    }

    final data = await postHttp(route, formData);
    return data;
  }

  @override
  Future<dynamic> deleteHttp(String route, dynamic body) async {
    Response response;
    try {
      final url = '${ApiRoutes.baseUrl}$route';
      print('URL : $url');
      print('body : $body');
      _dio = DioHelper.getDio(url);

      response = await _dio.delete(
        url,
        data: body,
      );
      print('My Response : $response');
    } on DioError catch (e) {
      network_helper.checkForNetworkExceptions(e.response);
    }
    network_helper.checkForNetworkExceptions(response);
    return response.data;
  }

  @override
  Future<File> downloadFile(String fileUrl, String subDirectory) async {
    Response response;
    final file = await _fileHelper.getFileFromUrl(fileUrl, subDirectory);
    _dio = Dio();

    try {
      print('File Path : ${file.path}');
      response = await _dio.download(fileUrl, file.path, onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        String percent = ((rec / total) * 100).toStringAsFixed(0) + "%";
        print('Percent : $percent');
      });
      print('Download Response : $response');
      return file;
    } on DioError catch (e) {
      network_helper.checkForNetworkExceptions(e.response);
    }
  }

  @override
  void dispose() {
    _dio.clear();
    _dio.close();
  }
}
