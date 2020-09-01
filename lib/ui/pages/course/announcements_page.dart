import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:edustar/ui/widgets/progress_child_container.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/repositories/author_repository.dart';
import '../../../core/view_models/announcement_view_model.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';

class AnnouncementsPage extends StatelessWidget {
  final Course course;

  const AnnouncementsPage({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements', style: appBarTheme),
      ),
      body: BaseView<AnnouncementViewModel>(
        model: AnnouncementViewModel(authorRepository: AuthorRepository()),
        onModelReady: (model) => model.getAnnouncements(course),
        builder: (context, model, child) => ProgressChildContainer(
          busy: (model.state == ViewState.busy),
          child: (model.announcements == null && model.state != ViewState.busy)
              ? Text(
                  'There are no announcemnts from the instructor',
                  style: context.textTheme().headline6,
                )
              : ListView.separated(
                  itemCount: model.announcements?.length ?? 0,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: model.announcements[index].author.avatar,
                            width: 40.0,
                            height: 40.0,
                            errorWidget: (_, __, ___) => Icon(Icons.error, color: Colors.black),
                          ),
                        ),
                        title: Text(model.announcements[index].author.name, style: context.textTheme().subtitle1),
                        subtitle: Text(model.announcements[index]?.createdAt ?? '', style: context.textTheme().bodyText2.copyWith(color: Colors.grey)),
                      ),
                      Text(
                        model.announcements[index].description,
                        style: context.textTheme().bodyText1.copyWith(fontSize: 15.0),
                      ).paddingAll(10.0)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
