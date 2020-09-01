import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/repository_exception.dart';
import '../models/author.dart';
import '../repositories/author_repository.dart';
import 'base_view_model.dart';

class InstructorViewModel extends BaseViewModel {
  final AuthorRepository _authorRepository;
  Author _author;

  Author get author => _author;

  InstructorViewModel({@required AuthorRepository authorRepository})
      : assert(authorRepository != null),
        _authorRepository = authorRepository;

  void setAuthor(Author author) {
    _author = author;
    notifyListeners();
  }

  Future<void> getInstructorProfile(int authorId, int userId) async {
    setState(ViewState.busy);
    try {
      final author = await _authorRepository.getAuthorProfile(authorId, userId);
      setAuthor(author);
      setState(ViewState.idle);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
