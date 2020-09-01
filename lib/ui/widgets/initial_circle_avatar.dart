import 'package:flutter/material.dart';

import '../../core/extensions/theme_x.dart';

class InitialCircleAvatar extends StatelessWidget {
  final String name;

  const InitialCircleAvatar({
    Key key,
    @required this.name,
  })  : assert(name != null, 'Username should not be null'),
        assert(name != '', 'Username should not be empty'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme().scaffoldBackgroundColor,
      height: 120.0,
      width: 120.0,
      child: CircleAvatar(
        backgroundColor: context.theme().primaryColorLight,
        child: Text(getUserNamesInitial(name), style: context.textTheme().headline4),
      ),
    );
  }

  String getUserNamesInitial(String name) {
    final beforeNonLeadingCapitalLetter = RegExp(r"(?=(?!^)[A-Z])");
    List<String> splitPascalCase(String input) => input.split(beforeNonLeadingCapitalLetter);

    final splittedWords = splitPascalCase(name);
    final String firstChar = splittedWords[0].substring(0, 1);

    if (splittedWords.length > 1) {
      final String secondChar = splittedWords[1].substring(0, 1);
      return firstChar + secondChar;
    }
    return firstChar;
  }
}
