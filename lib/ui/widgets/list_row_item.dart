import 'package:flutter/material.dart';

import '../../core/extensions/theme_x.dart';
import '../shared/ui_helper.dart';

class ListRowItem extends StatelessWidget {
  final String accountName;
  final IconData icon;
  final Function listRowHandler;

  ListRowItem({
    @required this.accountName,
    @required this.icon,
    @required this.listRowHandler,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: listRowHandler,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 48.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(icon, size: 22.0),
                      SizedBox(width: 10.0),
                      Text(
                        accountName,
                        style: context.textTheme().bodyText1.copyWith(fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceExtraSmall(),
              ],
            ),
          ),
          SizedBox(child: Divider(), height: 0.2)
        ],
      ),
    );
  }
}
