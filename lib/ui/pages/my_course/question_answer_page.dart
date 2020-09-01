import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/view_routes.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/question_request.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/question_answer_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';
import 'question_list_item_view.dart';

class QuestionAnswerPage extends StatefulWidget {
  final Course course;

  const QuestionAnswerPage({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleTextEditingController;
  TextEditingController descriptionTextEditingController;

  bool isPostQuestion = false;

  @override
  void initState() {
    super.initState();
    titleTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final user = locator<LocalStorageService>().user;

    return BaseView<QuestionAnswerViewModel>(
      model: QuestionAnswerViewModel(courseRepository: CourseRepository()),
      onModelReady: (model) => model.getAllQuestionsAndAnswer(widget.course.id, '${user.id}'),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text(locale.questionAnswer, style: appBarTheme)),
        body: model.state == ViewState.busy
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(10.0),
                child: model.questionAnswers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(AssetImages.emptyCategoryCourse, width: 200.0, height: 200.0),
                            UIHelper.verticalSpaceMedium(),
                            Text(locale.emptyQuestion, style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    : showQuestionListView(model, widget.course.id, '${user.id}'),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            titleTextEditingController.text = '';
            descriptionTextEditingController.text = '';
            var busy = false;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: StatefulBuilder(
                  builder: (context, setAlertState) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: titleTextEditingController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(hintText: 'Enter your question'),
                            ),
                          ),
                          UIHelper.verticalSpaceMedium(),
                          SizedBox(
                            height: 40.0,
                            child: busy
                                ? Center(child: CircularProgressIndicator())
                                : FormSubmitButton(
                                    borderRadius: 0.0,
                                    title: 'POST QUESTION',
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        setAlertState(() {
                                          busy = true;
                                        });
                                        postQuestion(model);
                                      }
                                    },
                                  ),
                          ).paddingAll(8.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void postQuestion(QuestionAnswerViewModel model) async {
    final user = locator<LocalStorageService>().user;
    final QuestionRequest questionRequest = QuestionRequest(
      courseId: widget.course.id,
      question: titleTextEditingController.text,
      userId: user.id,
      instructorId: widget.course.userId,
      id: 0,
    );
    await model.postUpdateQuestion(questionRequest);
    Navigator.of(context, rootNavigator: true).pop();
  }

  ListView showQuestionListView(QuestionAnswerViewModel model, int courseId, String userId) => ListView.separated(
        itemCount: model.questionAnswers.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => QuestionListItemView(
          questionAnswer: model.questionAnswers[index],
          listItemTapped: () async {
            final isPopped = await Navigator.pushNamed(context, ViewRoutes.questionAnswerDetail, arguments: model.questionAnswers[index]);
            if (isPopped != null && isPopped) {
              model.getAllQuestionsAndAnswer(courseId, userId);
            }
          },
        ),
      );
}
