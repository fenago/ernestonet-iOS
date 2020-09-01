import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/theme_x.dart';
import '../shared/ui_helper.dart';

class UserHeader extends StatelessWidget {
  final String name;
  final String image;
  final String date;

  const UserHeader({
    Key key,
    @required this.name,
    @required this.image,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              height: 40.0,
              width: 40.0,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
          UIHelper.horizontalSpaceMedium(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: context.textTheme().bodyText1.copyWith(fontSize: 14.0)),
              UIHelper.verticalSpaceSmall(),
              Text(date, style: context.textTheme().bodyText1.copyWith(color: Colors.grey, fontSize: 12.0)),
            ],
          ),
        ],
      ),
    );
  }
}
