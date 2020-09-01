import 'package:flutter/material.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/models/answer.dart';
import '../../../core/models/author.dart';
import '../../widgets/user_header.dart';
import '../../shared/ui_helper.dart';

class AnswerListItemView extends StatelessWidget {
  final bool isDeleteNeeded;
  final Answer answer;
  final Author author;
  final VoidCallback onDeleteClick;

  const AnswerListItemView({
    Key key,
    this.isDeleteNeeded = false,
    @required this.answer,
    @required this.author,
    @required this.onDeleteClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: UserHeader(
                  name: author?.name,
                  image: author?.avatar,
                  date: answer.createdAt,
                ),
              ),
              isDeleteNeeded
                  ? IconButton(
                      icon: Icon(Icons.delete_outline),
                      iconSize: 20.0,
                      color: Palette.appColor,
                      onPressed: onDeleteClick,
                    )
                  : SizedBox(),
            ],
          ),
          UIHelper.verticalSpaceSmall(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              child: Text(answer?.answer, style: context.textTheme().bodyText1),
            ),
          ),
        ],
      ),
    );
  }
}
