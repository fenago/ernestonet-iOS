import 'dart:io';

import 'package:edustar/core/models/course/course.dart';
import 'package:flutter/foundation.dart';

import '../exceptions/repository_exception.dart';
import '../repositories/course/course_repository.dart';
import 'base_view_model.dart';

class PurchaseCourseDetailViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  String videoUrl;
  Course _course;
  bool isNewVideo = false;
  File downloadedVideo;

  Course get course => _course;

  PurchaseCourseDetailViewModel({
    @required courseRepository,
  }) : _courseRepository = courseRepository;

  void refreshPage() {
    notifyListeners();
  }

  void setCourse(Course course) {
    _course = course;
    notifyListeners();
  }

  void setCourseVideo(File videoFile) {
    downloadedVideo = videoFile;
    notifyListeners();
  }

  void setVideo(String url, bool newVideo) {
    videoUrl = url;
    isNewVideo = newVideo;
    notifyListeners();
  }

  Future<void> downloadCourse(String url, subDirectory) async {
    setState(ViewState.busy);
    try {
      final file = await _courseRepository.downloadVideo(url, subDirectory);
      setCourseVideo(file);
      setState(ViewState.idle);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }

  Future<void> getCourseDetail(int id) async {
    try {
      setState(ViewState.idle);
      final course = await _courseRepository.courseDetail(id);
      setCourse(course);
    } on RepositoryException {
      setState(ViewState.error);
      setState(ViewState.idle);
    }
  }
}
