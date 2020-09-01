import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/repository_exception.dart';
import '../models/question_answer.dart';
import '../models/question_request.dart';
import '../repositories/course/course_repository.dart';
import 'base_view_model.dart';

class QuestionAnswerDetailViewModel extends BaseViewModel {
  final CourseRepository _courseRepository;

  QuestionAnswer _questionAnswer;

  QuestionAnswer get questionAnswer => _questionAnswer;

  QuestionAnswerDetailViewModel({
    @required CourseRepository courseRepository,
    @required QuestionAnswer questionAnswer,
  })  : _courseRepository = courseRepository,
        _questionAnswer = questionAnswer;

  void setQuestionAnswer(QuestionAnswer questionAnswer) {
    _questionAnswer = questionAnswer;
    notifyListeners();
  }

  Future<void> updateQuestion(QuestionRequest questionRequest) async {
    setState(ViewState.busy);
    try {
      final questionAnswer = await _courseRepository.postUpdateQuestion(questionRequest);
      setState(ViewState.idle);
      setQuestionAnswer(questionAnswer);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    }
  }

  Future<bool> deleteQuestion(QuestionRequest questionRequest) async {
    setState(ViewState.busy);
    try {
      final questionAnswer = await _courseRepository.deleteQuestion(questionRequest);
      setState(ViewState.idle);
      return questionAnswer;
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }

  Future<void> postAnswer(QuestionRequest questionRequest) async {
    setState(ViewState.busy);
    try {
      final questionAnswer = await _courseRepository.postAnswer(questionRequest);
      setState(ViewState.idle);
      setQuestionAnswer(questionAnswer);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }

  Future<bool> deleteAnswer(QuestionRequest questionRequest, int index) async {
    setState(ViewState.busy);
    try {
      final questionAnswer = await _courseRepository.deleteAnswer(questionRequest);
      setState(ViewState.idle);
      return questionAnswer;
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }
}
