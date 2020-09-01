import 'dart:io';

import '../../../locator.dart';
import '../../constants/api_routes.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/user.dart';
import '../../services/http/api_service.dart';
import '../../services/local_storage_service.dart';
import '../../utils/network_helper.dart' as network_helper;
import 'user_repository_base.dart';

class UserRepository implements UserRepositoryBase {
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  @override
  Future<void> fetchUser() async {
    try {
      User currentUser = _localStorageService.user;
      if (currentUser == null) {
        final response = await _apiService.getHttp(ApiRoutes.userProfile + '${currentUser.id}');
        print('user response : $response');
        _localStorageService.user = network_helper.decodeResponseBodyToBase(response).user;
      }
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<User> updateUser(User user, File file) async {
    try {
      final mapObj = user.toJson();
      mapObj.remove('user_img');
      final newMap = mapObj;
      final response = await _apiService.postHttpForm(ApiRoutes.updateProfile, newMap, [file]);
      return network_helper.decodeResponseBodyToBase(response).user;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<File> downloadVideo(String url, String subDirectory) async {
    try {
      final file = await _apiService.downloadFile(url, subDirectory);
      return file;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
