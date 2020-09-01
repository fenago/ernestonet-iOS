import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/models/onboard.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../shared/ui_helper.dart';

class OnboardContainer extends StatelessWidget {
  final Onboard onboard;

  OnboardContainer({@required this.onboard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      onboard.name,
                      textAlign: TextAlign.left,
                      style: context.textTheme().headline3.copyWith(fontSize: 28.0),
                      maxLines: 2,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Text(
                      onboard.description,
                      textAlign: TextAlign.left,
                      style: context.textTheme().bodyText1.copyWith(fontSize: 18.0, color: Colors.blueGrey),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: (onboard?.image != '') ? onboard.image : '',
                  placeholder: (context, url) => SizedBox(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ).paddingVerticalHorizontal(20.0, 10.0),
              ),
              UIHelper.verticalSpaceExtraLarge(),
            ],
          ).paddingAll(15.0),
        ),
      ),
    );
  }
}
