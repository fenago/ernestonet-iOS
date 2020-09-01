import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/question_answer.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/models/question_request.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/question_answer_detail_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';
import 'answer_list_item_view.dart';
import 'question_list_item_view.dart';

class QuestionAnswerDetailPage extends StatefulWidget {
  final QuestionAnswer questionAnswer;

  const QuestionAnswerDetailPage({
    Key key,
    @required this.questionAnswer,
  }) : super(key: key);

  @override
  _QuestionAnswerDetailPageState createState() => _QuestionAnswerDetailPageState();
}

class _QuestionAnswerDetailPageState extends State<QuestionAnswerDetailPage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<QuestionAnswerDetailViewModel>(
      model: QuestionAnswerDetailViewModel(courseRepository: CourseRepository(), questionAnswer: widget.questionAnswer),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(locale.questionDetail, style: appBarTheme),
        ),
        body: (model.state == ViewState.busy)
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                body: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      QuestionListItemView(
                        questionAnswer: model.questionAnswer,
                        listItemTapped: () {},
                      ),
                      model.questionAnswer.currentUser ? QuestionEditDeleteView(buildContext: context, model: model) : SizedBox(),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: model.questionAnswer.answers.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) => AnswerListItemView(
                            isDeleteNeeded: model.questionAnswer.currentUser,
                            author: model.questionAnswer.author,
                            answer: model.questionAnswer.answers[index],
                            onDeleteClick: () async {
                              final QuestionRequest questionRequest = QuestionRequest(
                                courseId: model.questionAnswer.courseId,
                                answerId: model.questionAnswer.answers[index].id,
                                ansUserId: model.questionAnswer.userId,
                                id: 0,
                              );
                              final isDeleted = await model.deleteAnswer(questionRequest, index);
                              if (isDeleted) {
                                model.questionAnswer.answers.removeAt(index);
                                model.setQuestionAnswer(model.questionAnswer);
                              }
                            },
                          ),
                        ),
                      ),
                      Divider(),
                      FooterView(questionAnswerModel: model)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class FooterView extends StatefulWidget {
  final QuestionAnswerDetailViewModel questionAnswerModel;

  const FooterView({Key key, @required this.questionAnswerModel}) : super(key: key);
  @override
  _FooterViewState createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {
  TextEditingController _submitResponseTextEditingController;

  @override
  void initState() {
    super.initState();
    _submitResponseTextEditingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _submitResponseTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _submitResponseTextEditingController,
              decoration: InputDecoration(
                hintText: 'Submit your response',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            child: Text('POST', style: TextStyle(color: context.theme().accentColor)),
            onPressed: () async {
              final QuestionRequest questionRequest = QuestionRequest(
                courseId: widget.questionAnswerModel.questionAnswer.courseId,
                questionId: widget.questionAnswerModel.questionAnswer.id,
                answer: _submitResponseTextEditingController.text,
                ansUserId: widget.questionAnswerModel.questionAnswer.userId,
                id: 0,
              );
              await widget.questionAnswerModel.postAnswer(questionRequest);
            },
          ),
        ],
      ),
    );
  }
}

class QuestionEditDeleteView extends StatefulWidget {
  final BuildContext buildContext;
  final QuestionAnswerDetailViewModel model;

  const QuestionEditDeleteView({
    Key key,
    @required this.buildContext,
    @required this.model,
  }) : super(key: key);

  @override
  _QuestionEditDeleteViewState createState() => _QuestionEditDeleteViewState();
}

class _QuestionEditDeleteViewState extends State<QuestionEditDeleteView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleTextEditingController;
  TextEditingController descriptionTextEditingController;

  QuestionAnswerDetailViewModel get questionModel => widget.model;

  String selectedTopic;

  @override
  void initState() {
    super.initState();
    titleTextEditingController = TextEditingController(text: questionModel.questionAnswer.question);
    descriptionTextEditingController = TextEditingController(text: 'questionModel.questionAnswer.description');
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        height: 40.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: OutlineButton(
                child: Text('EDIT'),
                onPressed: () async {
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
                                          title: 'UPDATE QUESTION',
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();
                                              setAlertState(() {
                                                busy = true;
                                              });
                                              final user = locator<LocalStorageService>().user;
                                              final QuestionRequest questionRequest = QuestionRequest(
                                                courseId: questionModel.questionAnswer.courseId,
                                                question: titleTextEditingController.text,
                                                instructorId: questionModel.questionAnswer.userId.toString(),
                                                userId: user.id,
                                                id: questionModel.questionAnswer.id,
                                              );
                                              await widget.model.updateQuestion(questionRequest);
                                              Navigator.of(context, rootNavigator: true).pop();
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
            Expanded(
              child: OutlineButton(
                child: Text('DELETE'),
                onPressed: () async {
                  final user = locator<LocalStorageService>().user;
                  final QuestionRequest questionRequest = QuestionRequest(
                    courseId: questionModel.questionAnswer.courseId,
                    questionId: questionModel.questionAnswer.id,
                    userId: user.id,
                  );
                  final isDeleted = await widget.model.deleteQuestion(questionRequest);
                  if (isDeleted != null && isDeleted) {
                    Navigator.pop(widget.buildContext, true);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
