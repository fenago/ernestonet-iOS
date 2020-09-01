import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/models/course/course_include.dart';
import 'package:edustar/ui/widgets/course/iframe_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/models/course/review.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/cart_badge_view_model.dart';
import '../../../core/view_models/course_detail_view_model.dart';
import '../../../core/view_models/player_ratation_view_model.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/card_button.dart';
import '../../widgets/course/custom_video_player.dart';
import '../../widgets/progress_child_container.dart';
import '../base_view.dart';
import '../reviews_page.dart';

class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({Key key, this.course}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final localStorageService = locator<LocalStorageService>();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: BaseView<CourseDetailViewModel>(
        model: CourseDetailViewModel(
          courseRepository: CourseRepository(),
        ),
        onModelReady: (model) => model.getCourseDetail(widget.course.id),
        builder: (context, model, child) => Scaffold(
          appBar: model.course == null ? AppBar() : null,
          body: SafeArea(
            child: (model.state == ViewState.busy || model.course == null)
                ? Center(child: CircularProgressIndicator())
                : BaseView<PlayerRotationViewModel>(
                    model: PlayerRotationViewModel(),
                    builder: (context, playerRotation, child) => Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: playerRotation.isFullScreen ? 1 : 2,
                          // child: IFrameVideoPlayer(),
                          child: CustomVideoPlayer(
                            videoUrl: model.course.video,
                            course: model.course,
                            toUpdate: false,
                            fullScreenPressed: () {
                              playerRotation.toggleFullscreen();
                            },
                          ),
                        ),
                        playerRotation.isFullScreen
                            ? SizedBox()
                            : Expanded(
                                flex: 4,
                                child: SingleChildScrollView(
                                  child: ProgressChildContainer(
                                    busy: (model.state == ViewState.busy),
                                    child: Container(
                                      color: localStorageService.darkMode ? Colors.grey[800] : Colors.grey[200],
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            color: context.theme().scaffoldBackgroundColor,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  model.course.title,
                                                  maxLines: 3,
                                                  style: context.textTheme().headline4,
                                                ),
                                                UIHelper.verticalSpaceSmall(),
                                                Text(
                                                  model.course.author.name,
                                                  maxLines: 3,
                                                  style: context.textTheme().subtitle2,
                                                ),
                                                UIHelper.verticalSpaceMedium(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${model.course.type != 'paid' ? locale.free : model.course.currency.symbol + ' ' + model.course.discountPrice}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 24.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    UIHelper.horizontalSpaceSmall(),
                                                    if (model.course.type == 'paid')
                                                      Text(
                                                        '${model.course.currency.symbol + ' ' + model.course.price}',
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          decoration: TextDecoration.lineThrough,
                                                        ),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          UIHelper.verticalSpaceSmall(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              (model.course.type == 'free')
                                                  ? CardButton(
                                                      busy: (model.isCartLoading),
                                                      title: locale.enrollNow,
                                                      onPressed: () async {
                                                        final boughtCourse = await model.enrollFreeCourse(model.course);
                                                        if (boughtCourse) {
                                                          Navigator.pushNamed(context, ViewRoutes.courseEnrolledStarted, arguments: model.course);
                                                        }
                                                      },
                                                    )
                                                  : CardButton(
                                                      busy: (model.isCartLoading),
                                                      title: (model.course.cart == false) ? locale.addToCart : locale.addedToCart,
                                                      onPressed: () async {
                                                        addRemoveCart(locale, model);
                                                      },
                                                    ),
                                              UIHelper.horizontalSpaceSmall(),
                                              CardButton(
                                                busy: (model.isWishlistLoading),
                                                title: (model.course.wishlist) ? locale.addedToWishlist : locale.addToWishlist,
                                                onPressed: () async {
                                                  addRemoveWishlist(locale, model);
                                                },
                                              ),
                                            ],
                                          ).paddingHorizontal(10.0),
                                          UIHelper.verticalSpaceSmall(),
                                          if (model.course?.courseIncludes != null && model.course.courseIncludes.isNotEmpty)
                                            _CourseIncludesView(
                                              courseIncludes: model.course.courseIncludes,
                                            ),
                                          if (model.course?.benefits != null && model.course.benefits.isNotEmpty) _WhatWillILearnView(course: model.course),
                                          if (model.course?.detail != null && model.course?.detail != '') TextDescriptionView(title: locale.description, desc: model.course.detail),
                                          if (model.course?.requirement != null && model.course?.requirement != '')
                                            TextDescriptionView(title: locale.requirements, desc: model.course.requirement),
                                          _CurriculumView(course: model.course),
                                          _AuthorView(authorId: model.course.userId, course: model.course),
                                          model.course.reviews.isNotEmpty ? _StudentFeedbackView(course: model.course) : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void addRemoveCart(AppLocalizations locale, CourseDetailViewModel model) async {
    if (!model.course.cart) {
      // ADD TO CART
      await model.updateCart(model.course, addToCart: true);
    } else {
      // REMOVE FROM CART
      await model.updateCart(model.course, addToCart: false);
    }
    await context.read<CartBadgeViewModel>().getCartCourses();
    model.refreshCourse();
  }

  void addRemoveWishlist(AppLocalizations locale, CourseDetailViewModel model) async {
    if (!model.course.wishlist) {
      await model.updateWishlist(model.course, addToWishlist: true);
    } else {
      await model.updateWishlist(model.course, addToWishlist: false);
    }
    model.refreshCourse();
  }
}

class _CourseIncludesView extends StatelessWidget {
  final List<CourseInclude> courseIncludes;

  const _CourseIncludesView({
    Key key,
    @required this.courseIncludes,
  })  : assert(courseIncludes != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(locale.courseIncludes, style: context.textTheme().subtitle2.copyWith(fontSize: 17.0)),
          UIHelper.verticalSpaceSmall(),
          for (var courseInclude in courseIncludes)
            _buildCourseIncludesTile(
              context,
              icon: Icons.bookmark_border,
              title: '${courseInclude.detail}',
            ),
        ],
      ),
    );
  }

  Widget _buildCourseIncludesTile(BuildContext context, {IconData icon, String title}) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Icon(icon),
            UIHelper.horizontalSpaceExtraSmall(),
            Flexible(
                child: Text(
              title,
              style: context.textTheme().bodyText1,
              maxLines: 2,
            )),
          ],
        ),
      );
}

class _WhatWillILearnView extends StatelessWidget {
  final Course course;

  const _WhatWillILearnView({Key key, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 8.0),
      padding: const EdgeInsets.all(10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UIHelper.verticalSpaceSmall(),
          Text(locale.whatWillILearn, style: context.textTheme().subtitle2.copyWith(fontSize: 17.0)),
          UIHelper.verticalSpaceSmall(),
          Column(
            children: List.generate(
              course.benefits.length,
              (index) => _buildCourseIncludesTile(
                context,
                icon: Icons.check,
                title: course.benefits[index].detail,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildCourseIncludesTile(BuildContext context, {IconData icon, String title}) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Icon(icon),
            UIHelper.horizontalSpaceExtraSmall(),
            Flexible(
                child: Text(
              title,
              style: context.textTheme().bodyText1,
              maxLines: 2,
            )),
          ],
        ),
      );
}

class _CurriculumView extends StatefulWidget {
  final Course course;

  const _CurriculumView({Key key, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  _CurriculumViewState createState() => _CurriculumViewState();
}

class _CurriculumViewState extends State<_CurriculumView> {
  List<ExpansionTile> listOfExpansions;
  final local = locator<LocalStorageService>();

  Course get course => widget.course;

  @override
  void initState() {
    super.initState();
    listOfExpansions = List<ExpansionTile>.generate(
      course.curriculum.length,
      (index) => ExpansionTile(
        title: Text(
          course.curriculum[index].title,
          style: GoogleFonts.montserrat(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: local.darkMode ? Colors.white : Colors.black,
          ),
        ),
        children: course.curriculum[index].topics
            .map(
              (data) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.play_circle_filled, size: 16.0, color: Colors.grey),
                    UIHelper.horizontalSpaceMedium(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.title),
                        UIHelper.verticalSpaceSmall(),
                        Text('Video - ${data.duration}'),
                      ],
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Text(
              locale.curriculum,
              style: context.textTheme().subtitle2.copyWith(
                    fontSize: 17.0,
                  ),
            ),
          ),
          UIHelper.verticalSpaceSmall(),
          Column(
            children: listOfExpansions,
          ),
        ],
      ),
    );
  }
}

class TextDescriptionView extends StatelessWidget {
  final String title;
  final String desc;

  const TextDescriptionView({Key key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UIHelper.verticalSpaceSmall(),
          Text(
            title,
            style: context.textTheme().subtitle2.copyWith(fontSize: 17.0),
          ),
          UIHelper.verticalSpaceSmall(),
          Text(desc, style: context.textTheme().bodyText1, maxLines: 6),
          LayoutBuilder(
            builder: (context, size) {
              final span = TextSpan(text: desc);
              final tp = TextPainter(text: span, maxLines: 6, textDirection: TextDirection.ltr);
              tp.layout(maxWidth: size.maxWidth);
              if (tp.didExceedMaxLines) {
                return FlatButton(
                  child: Text(
                    locale.seeMore,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red[800]),
                  ),
                  onPressed: () {
                    final Map<String, dynamic> data = {
                      'title': title,
                      'desc': desc,
                    };
                    Navigator.pushNamed(
                      context,
                      ViewRoutes.descriptionDetail,
                      arguments: data,
                    );
                  },
                );
              } else {
                return SizedBox(height: 10.0);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AuthorView extends StatelessWidget {
  final String authorId;
  final Course course;

  final placeholder = Image.asset(
    AssetImages.largeLoader,
  );

  _AuthorView({
    Key key,
    @required this.authorId,
    @required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            locale.createdBy + course.author.name,
            style: context.textTheme().subtitle2.copyWith(fontSize: 17.0),
          ),
          UIHelper.verticalSpaceLarge(),
          Row(
            children: <Widget>[
              SizedBox(
                height: 80.0,
                width: 80.0,
                child: CachedNetworkImage(
                  width: 80.0,
                  height: 80.0,
                  imageUrl: (course.author.avatar != null && course.author.avatar != '') ? course.author.avatar : AssetImages.course,
                  placeholder: (context, url) => placeholder,
                  errorWidget: (context, url, error) => placeholder,
                  fit: BoxFit.cover,
                ),
              ),
              UIHelper.horizontalSpaceMedium(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTile(context, Icons.person_outline, course.author.noOfStudents, locale.students),
                  _buildTile(context, Icons.bookmark_border, course.author.noOfCourses, locale.courses),
                  _buildTile(context, Icons.star_border, course.author.noOfReviews, locale.ratings),
                ],
              )
            ],
          ),
          Center(
            child: FlatButton(
              child: Text(
                locale.viewProfile,
                style: TextStyle(color: Colors.red[800]),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                ViewRoutes.instructorProfile,
                arguments: int.parse(authorId),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTile<T>(BuildContext context, IconData icon, T number, String title) => Row(
        children: <Widget>[
          Icon(icon, size: 20.0, color: Colors.grey),
          UIHelper.horizontalSpaceExtraSmall(),
          Text('$number', style: context.textTheme().bodyText1),
          UIHelper.horizontalSpaceExtraSmall(),
          Text(title, style: context.textTheme().bodyText1),
        ],
      );
}

class _StudentFeedbackView extends StatelessWidget {
  final Course course;

  const _StudentFeedbackView({Key key, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: context.theme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(locale.studentFeedback, style: context.textTheme().subtitle2.copyWith(fontSize: 17.0)),
          UIHelper.verticalSpaceSmall(),
          Row(
            children: <Widget>[
              Text('${course.avgRating}', style: TextStyle(fontSize: 50.0)),
              UIHelper.horizontalSpaceSmall(),
              Text(locale.ratings, style: context.textTheme().bodyText1, textAlign: TextAlign.end),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
          Column(
            children: List.generate(
              (course.reviews.length <= 2) ? course.reviews.length : 2,
              (index) => _RatingReviewView(
                review: course.reviews[index],
              ),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                locale.seeMore,
                style: TextStyle(color: Colors.red[800]),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewsPage(course: course),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingReviewView extends StatelessWidget {
  final Review review;

  const _RatingReviewView({Key key, @required this.review})
      : assert(review != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RatingBar(
            itemSize: 18.0,
            initialRating: 3,
            minRating: 1,
            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          UIHelper.verticalSpaceExtraSmall(),
          if (review.review.isNotEmpty) Text(review.review, style: context.textTheme().bodyText1, maxLines: 5),
          UIHelper.verticalSpaceExtraSmall(),
          Row(
            children: <Widget>[
              Text(review?.reviewerName ?? '', style: TextStyle(color: Colors.grey[700])),
              UIHelper.horizontalSpaceSmall(),
              Text(review?.createdAt ?? '', style: TextStyle(color: Colors.grey))
            ],
          ),
        ],
      ),
    );
  }
}
