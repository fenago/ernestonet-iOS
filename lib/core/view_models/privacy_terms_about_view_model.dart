import 'package:flutter/material.dart';

import '../exceptions/repository_exception.dart';
import '../repositories/app_repository.dart';
import '../utils/alert_dialog_helper.dart' as alert_helper;
import 'base_view_model.dart';

enum AppDetail { about, privacy, terms }

class PrivacyTermsAboutViewModel extends BaseViewModel {
  final AppRepository _appRepository;
  String _content;

  String get content => _content;

  PrivacyTermsAboutViewModel({@required AppRepository appRepository})
      : assert(AppRepository != null),
        _appRepository = appRepository;

  setContents(String content) {
    _content = content;
    notifyListeners();
  }

  Future<void> getAppDetails(AppDetail appDetail) async {
    setState(ViewState.busy);
    try {
      final content = await _appRepository.getAppDetails(appDetail);
      setContents(content);
    } on RepositoryException catch (e) {
      setState(ViewState.idle);
      alert_helper.showErrorAlert(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }
}
