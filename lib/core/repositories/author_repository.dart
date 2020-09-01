import 'package:edustar/core/models/announcement.dart';
import 'package:edustar/core/models/course/course.dart';

import '../../core/utils/network_helper.dart' as network_helper;
import '../../locator.dart';
import '../constants/api_routes.dart';
import '../exceptions/network_exception.dart';
import '../exceptions/repository_exception.dart';
import '../models/author.dart';
import '../services/http/api_service.dart';

class AuthorRepository {
  final ApiService _apiService = locator<ApiService>();

  Future<Author> getAuthorProfile(int authorId, int userId) async {
    try {
      final response = await _apiService.getHttp(ApiRoutes.author + '$authorId' + '&user_id=$userId');
      return network_helper.decodeResponseBodyToBase(response).author;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<List<Announcement>> getAuthorAnnouncements(Course course) async {
    try {
      final response = await _apiService.getHttp(ApiRoutes.announcement + course.userId + '&c_id=${course.id}');
      return network_helper.decodeResponseBodyToBase(response).announcements;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
