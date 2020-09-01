import 'package:edustar/core/view_models/privacy_terms_about_view_model.dart';

import '../../core/utils/network_helper.dart' as network_helper;
import '../../locator.dart';
import '../constants/api_routes.dart';
import '../exceptions/network_exception.dart';
import '../exceptions/repository_exception.dart';
import '../services/http/api_service.dart';

class AppRepository {
  final ApiService _apiService = locator<ApiService>();

  Future<String> getAppDetails(AppDetail appDetailType) async {
    try {
      final response = await _apiService.getHttp(getAppUrl(appDetailType));
      return network_helper.decodeResponseBodyToBase(response).content;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  String getAppUrl(AppDetail appDetail) {
    switch (appDetail) {
      case AppDetail.terms:
        return ApiRoutes.termsOfServices;
      case AppDetail.privacy:
        return ApiRoutes.privacy;
      default:
        return ApiRoutes.about;
    }
  }
}
