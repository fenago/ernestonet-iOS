import 'package:edustar/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class RemoveListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: Text(
        locale.remove,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
