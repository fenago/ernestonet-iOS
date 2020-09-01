import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/models/question_answer.dart';
import '../../widgets/user_header.dart';
import '../../shared/ui_helper.dart';

class QuestionListItemView extends StatelessWidget {
  final QuestionAnswer questionAnswer;
  final VoidCallback listItemTapped;

  const QuestionListItemView({
    Key key,
    @required this.questionAnswer,
    @required this.listItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => listItemTapped(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UserHeader(
                name: questionAnswer.author.name,
                image: questionAnswer.author.avatar,
                date: questionAnswer.createdAt,
              ),
              UIHelper.horizontalSpaceSmall(),
              Text('', style: context.textTheme().subtitle2.copyWith(fontSize: 13.0, color: Palette.appColor)),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
          ContentView(questionAnswer: questionAnswer),
          UIHelper.verticalSpaceMedium(),
          Text('${questionAnswer.answers.length} RESPONSE', style: context.textTheme().subtitle2.copyWith(fontSize: 13.0, color: Palette.appColor)),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  final QuestionAnswer questionAnswer;

  const ContentView({Key key, @required this.questionAnswer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceSmall(),
          Text(questionAnswer.question, style: context.textTheme().bodyText1),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
