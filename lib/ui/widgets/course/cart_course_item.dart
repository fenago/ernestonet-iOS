import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/api_routes.dart';
import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';

class CartCourseItem extends StatelessWidget {
  final Course course;
  final VoidCallback onRemoved;

  const CartCourseItem({
    Key key,
    @required this.course,
    @required this.onRemoved,
  })  : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            padding: const EdgeInsets.only(bottom: 30.0),
            child: CachedNetworkImage(
              imageUrl: (course.image != null) ? course.image : ApiRoutes.mediaBaseUrl + AssetImages.course,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
          UIHelper.horizontalSpaceMedium(),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme().subtitle2,
                ),
                UIHelper.verticalSpaceSmall(),
                Text(course.author.name),
                UIHelper.verticalSpaceSmall(),
                Row(
                  children: <Widget>[
                    Text(
                      '${course.currency.symbol} ${course.discountPrice}',
                      style: GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(locale.remove, style: TextStyle(color: Palette.appColor)),
                      onPressed: onRemoved,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
