import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/core/view_models/purchased_course_root_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/models/course/curriculum.dart';
import '../../../core/models/course/topic.dart';
import '../../../core/models/indexpath.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/custom_video_player_view_model.dart';
import '../../../core/view_models/player_ratation_view_model.dart';
import '../../../core/view_models/purchase_course_detail_view_model.dart';
import '../../widgets/course/custom_video_player.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/course/topic_list_item.dart';
import '../base_view.dart';

class PurchaseCourseDetailPage extends StatefulWidget {
  final Course course;

  PurchaseCourseDetailPage({Key key, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  _PurchaseCourseDetailPageState createState() => _PurchaseCourseDetailPageState();
}

class _PurchaseCourseDetailPageState extends State<PurchaseCourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    CustomVideoPlayerViewModel videoPlayerModel;

    return BaseView<PurchaseCourseRootDetailViewModel>(
      model: PurchaseCourseRootDetailViewModel(
        courseRepository: CourseRepository(),
      ),
      onModelReady: (rootModel) => rootModel.getCourseDetail(widget.course.id),
      builder: (context, rootModel, child) => (rootModel.state == ViewState.busy || rootModel.course == null)
          ? Container(color: Colors.white, child: Center(child: CircularProgressIndicator()))
          : BaseView<PurchaseCourseDetailViewModel>(
              model: PurchaseCourseDetailViewModel(
                courseRepository: CourseRepository(),
              ),
              builder: (context, model, child) => Scaffold(
                appBar: model.course == null ? AppBar() : null,
                body: SafeArea(
                  top: false,
                  child: ChangeNotifierProvider<PlayerRotationViewModel>(
                    create: (context) => PlayerRotationViewModel(),
                    child: Consumer<PlayerRotationViewModel>(
                      builder: (context, playerRotation, child) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          WillPopScope(
                            onWillPop: () {
                              if (playerRotation.isFullScreen) {
                                resetCurrentPlaying(rootModel);
                                Navigator.pushReplacementNamed(
                                  context,
                                  ViewRoutes.purchaseCourseDetail,
                                  arguments: rootModel.course,
                                );
                              } else {
                                resetCurrentPlaying(rootModel);
                                Navigator.pop(context);
                              }
                              return Future.value(false);
                            },
                            child: Expanded(
                              flex: playerRotation.isFullScreen ? 1 : 2,
                              child: getVideoPlayer(rootModel, model, playerRotation),
                            ),
                          ),
                          playerRotation.isFullScreen
                              ? SizedBox()
                              : Expanded(
                                  flex: 4,
                                  child: LessonAboutMoreView(
                                    videoPlayerModel: videoPlayerModel,
                                    model: model,
                                    course: rootModel.course,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void resetCurrentPlaying(PurchaseCourseRootDetailViewModel rootModel) {
    for (var curriculum in rootModel.course.curriculum) {
      for (var topic in curriculum.topics) {
        topic.currentlyPlaying = false;
      }
    }
  }

  CustomVideoPlayer getVideoPlayer(PurchaseCourseRootDetailViewModel rootModel, PurchaseCourseDetailViewModel model, PlayerRotationViewModel playerRotation) {
    return CustomVideoPlayer(
      videoUrl: model?.videoUrl ?? rootModel.course.video,
      course: widget.course,
      toUpdate: (model?.videoUrl != null),
      isNewVideo: model.isNewVideo,
      fullScreenPressed: () {
        model.isNewVideo = false;
        playerRotation.toggleFullscreen();
      },
    );
  }
}

class LessonAboutMoreView extends StatefulWidget {
  final CustomVideoPlayerViewModel videoPlayerModel;
  final PurchaseCourseDetailViewModel model;
  final Course course;

  const LessonAboutMoreView({Key key, @required this.videoPlayerModel, @required this.model, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  _LessonAboutMoreViewState createState() => _LessonAboutMoreViewState();
}

class _LessonAboutMoreViewState extends State<LessonAboutMoreView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex = 0;

  Course get course => widget.course;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      print('Tab changing ${_tabController.index}');
      setState(() {
        selectedIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(text: locale.lesson),
                Tab(text: locale.more),
              ],
            ),
            _getTabView(selectedIndex),
          ],
        ),
      ),
    );
  }

  Widget _getTabView(int index) {
    switch (index) {
      case 0:
        return _LessonView(course: course);
        break;
      case 1:
        return _AboutView(course: course);
        break;
      default:
        return SizedBox();
    }
  }
}

typedef int NumberOfRowsCallBack(int section);
typedef int NumberOfSectionCallBack();
typedef Widget SectionWidgetCallBack(int section);
typedef Widget RowsWidgetCallBack(int section, int row);

class LessonSectionListView extends StatefulWidget {
  final NumberOfSectionCallBack numberOfSection;
  final NumberOfRowsCallBack numberOfRowsInSection;
  final SectionWidgetCallBack sectionWidget;
  final RowsWidgetCallBack rowWidget;
  final Course course;

  LessonSectionListView({
    this.numberOfSection,
    @required this.numberOfRowsInSection,
    this.sectionWidget,
    @required this.rowWidget,
    @required this.course,
  }) : assert(!(numberOfRowsInSection == null || rowWidget == null), 'numberOfRowsInSection and rowWidget are mandatory');

  @override
  _LessonSectionListViewState createState() => _LessonSectionListViewState();
}

class _LessonSectionListViewState extends State<LessonSectionListView> {
  var itemList = new List<int>();
  int itemCount = 0;
  int sectionCount = 0;

  @override
  void initState() {
    sectionCount = widget.numberOfSection();
    itemCount = listItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildCourseTitleAuthorView(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return buildItemWidget(index);
          },
          key: widget.key,
        ),
      ],
    );
  }

  Container _buildCourseTitleAuthorView() => Container(
        height: 110.0,
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Text(widget.course?.title ?? 'Not found', maxLines: 2, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
            ),
            UIHelper.verticalSpaceMedium(),
            Flexible(
              child: Text(widget.course.author.name, style: TextStyle(fontSize: 16.0, color: Colors.grey[700])),
            ),
          ],
        ),
      );

  int listItemCount() {
    itemList = new List<int>();
    int rowCount = 0;

    for (int i = 0; i < sectionCount; i++) {
      int rows = widget.numberOfRowsInSection(i);
      rowCount += rows + 1;
      itemList.insert(i, rowCount);
    }
    return rowCount;
  }

  Widget buildItemWidget(int index) {
    IndexPath indexPath = sectionModel(index);
    if (indexPath.row < 0) {
      return widget.sectionWidget != null
          ? widget.sectionWidget(indexPath.section)
          : SizedBox(
              height: 0,
            );
    } else {
      return widget.rowWidget(indexPath.section, indexPath.row);
    }
  }

  IndexPath sectionModel(int index) {
    int row = 0;
    int section = 0;
    for (int i = 0; i < sectionCount; i++) {
      int item = itemList[i];
      if (index < item) {
        row = index - (i > 0 ? itemList[i - 1] : 0) - 1;
        section = i;
        break;
      }
    }
    return IndexPath(section: section, row: row);
  }
}

class _LessonView extends StatefulWidget {
  final Course course;

  _LessonView({Key key, @required this.course})
      : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  __LessonViewState createState() => __LessonViewState();
}

class __LessonViewState extends State<_LessonView> {
  List<Curriculum> curriculums = [];
  List<List<Topic>> topics = [];
  String selectedUrl;

  @override
  void initState() {
    super.initState();
    curriculums = widget.course.curriculum;
    for (var curriculum in widget.course.curriculum) {
      topics.add(curriculum.topics);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseCourseDetailViewModel>(
      builder: (context, model, child) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: LessonSectionListView(
            course: widget.course,
            numberOfSection: () => curriculums.length,
            numberOfRowsInSection: (section) {
              return topics[section].length;
            },
            sectionWidget: (section) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Section ${section + 1} - ${curriculums[section].title}',
                  style: context.textTheme().subtitle1.copyWith(
                        fontSize: 13.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ).paddingAll(8.0),
              );
            },
            rowWidget: (section, row) {
              return InkWell(
                child: TopicListItem(
                  title: '${topics[section][row].title}',
                  duration: '${topics[section][row]?.duration ?? '0.0'}',
                  currentlyPlaying: topics[section][row].currentlyPlaying,
                  onDownloadPressed: () async {
                    if (topics[section][row]?.video == null || topics[section][row].video.isEmpty) {
                      alert_helper.showAlert('There is no video');
                      return;
                    }
                    final fileDirectoryPath = '/videos/${widget.course.id}/${curriculums[section].id}/${topics[section][row].id}/';
                    await model.downloadCourse(topics[section][row].video, fileDirectoryPath);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('File saved in Android/data/com.example.edustar/files'),
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {},
                      ),
                    ));
                  },
                ),
                onTap: () {
                  if (topics[section][row]?.video == null || topics[section][row].video.isEmpty) {
                    alert_helper.showAlert('There is no video');
                    return;
                  }
                  print('TOPIC VIDEO 🎦 : ${topics[section][row].video}');

                  if (!topics[section][row].currentlyPlaying) {
                    model.setVideo(topics[section][row].video, true);
                  }

                  // Setting the selection state, if user clicks the same item don't reload the video.
                  selectedUrl = '${topics[section][row].video}';

                  for (var topicsSection in topics) {
                    for (var topic in topicsSection) {
                      if (topic.video == '${topics[section][row].video}') {
                        topic.currentlyPlaying = true;
                      } else {
                        topic.currentlyPlaying = false;
                      }
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AboutView extends StatelessWidget {
  final Course course;

  final List<IconData> aboutImages = [
    Icons.more_horiz,
    Icons.share,
    Icons.chat_bubble_outline,
    Icons.notifications_none,
  ];

  _AboutView({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    final List<String> aboutDatas = [
      locale.aboutThisCourse,
      locale.shareThisCourse,
      locale.questionAnswer,
      locale.announcementNavTitle,
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: aboutDatas.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => openRoute(context, index, course: course),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
              child: Row(
                children: <Widget>[
                  Icon(aboutImages[index], color: Colors.grey[600], size: 24.0),
                  UIHelper.horizontalSpaceLarge(),
                  Text(
                    aboutDatas[index],
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openRoute(BuildContext context, int index, {Course course}) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, ViewRoutes.aboutCourse, arguments: course.detail);
        break;
      case 1:
        Share.share(
          'Look at this course!\n${course.courseUrl}',
        );
        break;
      case 2:
        Navigator.pushNamed(context, ViewRoutes.questionAnswer, arguments: course);
        break;
      default:
        Navigator.pushNamed(context, ViewRoutes.announcements, arguments: course);
    }
  }
}
