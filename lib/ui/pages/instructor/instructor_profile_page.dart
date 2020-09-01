import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/repositories/author_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/instructor_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/course/course_card_item.dart';
import '../base_view.dart';

class InstructorProfilePage extends StatelessWidget {
  final int authorId;

  const InstructorProfilePage({
    Key key,
    @required this.authorId,
  })  : assert(authorId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final user = locator<LocalStorageService>().user;
    return BaseView<InstructorViewModel>(
      model: InstructorViewModel(authorRepository: AuthorRepository()),
      onModelReady: (model) => model.getInstructorProfile(
        authorId,
        user.id,
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(locale.instructorNavTitle, style: appBarTheme),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: (model.state == ViewState.busy)
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            height: 120.0,
                            width: 120.0,
                            child: CachedNetworkImage(
                              imageUrl: (model.author.avatar != null) ? model.author.avatar : AssetImages.course,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset(AssetImages.largeLoader),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                        Text(
                          model.author.name,
                          style: context.textTheme().headline6.copyWith(fontSize: 24.0),
                        ),
                        UIHelper.verticalSpaceSmall(),
                        Text('Instructor', style: context.textTheme().bodyText1),
                        UIHelper.verticalSpaceLarge(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _CountView(title: locale.students, count: model.author.noOfStudents),
                            _CountView(title: locale.courses, count: model.author.noOfCourses),
                            _CountView(title: locale.ratings, count: model.author.noOfReviews),
                            UIHelper.horizontalSpaceLarge(),
                          ],
                        ),
                        UIHelper.verticalSpaceLarge(),
                        // TODO: Hidden Courses by Jason alab
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        //   height: 40.0,
                        //   child: Text(
                        //     '${locale.coursesBy} ${model.author.name}',
                        //     style: context.textTheme().subtitle2.copyWith(fontSize: 16.0),
                        //   ),
                        // ),

                        // _TeachingCourseList(
                        //   teachingCourses: model.author?.courses,
                        // ),
                        if (model.author?.aboutBio != null) _BioContactView(bio: model.author.aboutBio)
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _CountView<T> extends StatelessWidget {
  final String title;
  final T count;

  const _CountView({Key key, this.title, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final subTitleStyle = context.textTheme().subtitle2.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Text(title, style: subTitleStyle),
          UIHelper.verticalSpaceMedium(),
          Text('$count'),
        ],
      ),
    );
  }
}

class _TeachingCourseList extends StatefulWidget {
  final List<Course> teachingCourses;

  const _TeachingCourseList({Key key, @required this.teachingCourses}) : super(key: key);

  @override
  _TeachingCourseListState createState() => _TeachingCourseListState();
}

class _TeachingCourseListState extends State<_TeachingCourseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 200.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.teachingCourses?.length ?? 0,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => CourseCardItem(
          course: widget.teachingCourses[index],
          cardWidth: 170.0,
          imageHeight: 95.0,
        ),
      ),
    );
  }
}

class _BioContactView extends StatefulWidget {
  final String bio;

  _BioContactView({Key key, @required this.bio}) : super(key: key);

  @override
  __BioContactViewState createState() => __BioContactViewState();
}

class __BioContactViewState extends State<_BioContactView> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final darkMode = locator<LocalStorageService>().darkMode;
    bool isInitialLoaded = false;

    final divider = Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: 10.0,
      color: darkMode ? Colors.grey[800] : Colors.grey[200],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        divider,
        Text('About', style: context.textTheme().headline6).paddingVerticalHorizontal(10.0, 10.0),
        Container(
          height: context.mediaQuerySize().height / 3,
          color: isInitialLoaded ? context.theme().scaffoldBackgroundColor : Colors.transparent,
          child: Stack(
            children: [
              isInitialLoaded
                  ? SizedBox()
                  : Center(
                      child: SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
              WebView(
                initialUrl: 'about:blank',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  loadHtml(widget.bio);
                },
                onPageFinished: (String url) {
                  if (!isInitialLoaded) {
                    setState(() => isInitialLoaded = true);
                  }
                },
              ).paddingVerticalHorizontal(15.0, 10.0),
            ],
          ),
        ),
      ],
    );
  }

  void loadHtml(String htmlData) async {
    _controller.loadUrl(
      Uri.dataFromString(
        htmlData,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
