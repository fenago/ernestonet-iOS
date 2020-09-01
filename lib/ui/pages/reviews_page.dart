import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/extensions/theme_x.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/course/course.dart';
import '../../core/models/course/review.dart';
import '../shared/ui_helper.dart';
import '../shared/app_style.dart';

class ReviewsPage extends StatelessWidget {
  final Course course;

  ReviewsPage({Key key, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title,
          style: appBarTheme,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          color: context.theme().scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(locale.reviews, style: context.textTheme().headline6.copyWith(fontSize: 18.0)),
              UIHelper.verticalSpaceSmall(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${course.avgRating}', style: context.textTheme().headline6.copyWith(fontSize: 35.0)),
                  UIHelper.horizontalSpaceMedium(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildRatingBar('${course.avgRating}'),
                      UIHelper.verticalSpaceExtraSmall(),
                      Text('${course.reviews.length} ${locale.reviews}', style: context.textTheme().bodyText2.copyWith(color: Colors.grey)),
                    ],
                  )
                ],
              ),
              UIHelper.verticalSpaceSmall(),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: course.reviews.length,
                  itemBuilder: (context, index) => _buildRatingReviewView(context, course.reviews[index], '${course.avgRating}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildRatingReviewView(BuildContext context, Review review, String rating) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(review.reviewerName, style: context.textTheme().subtitle1),
            UIHelper.verticalSpaceSmall(),
            _buildRatingBar(rating),
            UIHelper.verticalSpaceExtraSmall(),
            Text(review.review, maxLines: 5),
            UIHelper.verticalSpaceExtraSmall(),
            Row(
              children: <Widget>[
                Text(review.reviewerName, style: TextStyle(color: Colors.grey[700])),
                UIHelper.horizontalSpaceSmall(),
                Text(review.createdAt, style: TextStyle(color: Colors.grey))
              ],
            ),
          ],
        ),
      );

  RatingBar _buildRatingBar(String rating) => RatingBar(
        itemSize: 18.0,
        initialRating: 3.0,
        minRating: 1,
        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      );
}
