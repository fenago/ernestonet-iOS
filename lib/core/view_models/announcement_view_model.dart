import 'package:edustar/core/models/course/course.dart';
import 'package:flutter/material.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/repository_exception.dart';
import '../models/announcement.dart';
import '../repositories/author_repository.dart';
import 'base_view_model.dart';

class AnnouncementViewModel extends BaseViewModel {
  final AuthorRepository _authorRepository;
  List<Announcement> _announcements;

  List<Announcement> get announcements => _announcements;

  AnnouncementViewModel({@required AuthorRepository authorRepository})
      : assert(authorRepository != null),
        _authorRepository = authorRepository;

  setAnnouncements(List<Announcement> announcements) {
    _announcements = announcements;
    notifyListeners();
  }

  Future<void> getAnnouncements(Course course) async {
    setState(ViewState.busy);
    try {
      final announcements = await _authorRepository.getAuthorAnnouncements(course);
      setAnnouncements(announcements);
      setState(ViewState.idle);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
