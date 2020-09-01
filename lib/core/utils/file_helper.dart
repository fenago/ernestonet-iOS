import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileHelperBase {
  Future<String> getApplicationDocumentsDirectoryPath();

  Future<File> getFileFromUrl(String url, String subDirectory);

  Future<MultipartFile> convertFileToMultipartFile(File file);
}

class FileHelper implements FileHelperBase {
  @override
  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<File> getFileFromUrl(String url, String subDirectory) async {
    final dir = await getExternalStorageDirectory();
    final file = File('${dir.path}$subDirectory${basename(url)}');
    return file;
  }

  @override
  Future<MultipartFile> convertFileToMultipartFile(File file) async {
    final fileBaseName = basename(file.path);
    final mimeType = lookupMimeType(fileBaseName);
    final contentType = MediaType.parse(mimeType);

    return MultipartFile.fromFileSync(
      file.path,
      filename: fileBaseName,
      contentType: contentType,
    );
  }
}
