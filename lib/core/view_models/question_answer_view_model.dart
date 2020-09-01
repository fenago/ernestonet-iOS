import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/repository_exception.dart';
import '../models/question_answer.dart';
import '../models/question_request.dart';
import '../repositories/course/course_repository.dart';
import 'base_view_model.dart';

class QuestionAnswerViewModel extends BaseViewModel {
  final CourseRepository _courseRepository;

  List<QuestionAnswer> _questionAnswers;

  List<QuestionAnswer> get questionAnswers => _questionAnswers;

  QuestionAnswerViewModel({
    @required CourseRepository courseRepository,
  }) : _courseRepository = courseRepository;

  void setAllQuestionAnswer(List<QuestionAnswer> questionAnswers) {
    _questionAnswers = questionAnswers;
    notifyListeners();
  }

  void insertQuestionAnswer(QuestionAnswer postedQuestion) {
    _questionAnswers.insert(0, postedQuestion);
    notifyListeners();
  }

  Future<void> getAllQuestionsAndAnswer(int courseId, String userId) async {
    setState(ViewState.busy);
    try {
      final questionAnswers = await _courseRepository.getQuestionAnswer(courseId, userId);
      setAllQuestionAnswer(questionAnswers);
      setState(ViewState.idle);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    }
  }

  Future<void> postUpdateQuestion(QuestionRequest questionRequest) async {
    setState(ViewState.busy);
    try {
      final questionAnswer = await _courseRepository.postUpdateQuestion(questionRequest);
      setState(ViewState.idle);
      insertQuestionAnswer(questionAnswer);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
