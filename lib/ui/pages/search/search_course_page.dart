// import 'package:flutter/material.dart';

// import '../../../core/extensions/media_query_x.dart';
// import '../../../core/extensions/theme_x.dart';
// import '../../../core/models/course/course.dart';
// import '../../shared/ui_helper.dart';
// import 'search_category_page.dart';
// import '../sort_filter_page.dart';
// import '../../shared/app_style.dart';
// import 'search_course_list_page.dart';

// class SearchCoursePage extends StatefulWidget {
//   final List<Course> courses;
//   String searchData;

//   SearchCoursePage({Key key, @required this.courses, this.searchData}) : super(key: key);

//   @override
//   _SearchCoursePageState createState() => _SearchCoursePageState();
// }

// class _SearchCoursePageState extends State<SearchCoursePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Flutter Development',
//           style: appBarTheme,
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.edit),
//             iconSize: 18,
//             onPressed: () async {
//               final searchData = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchCategoryPage()));
//               setState(() {
//                 widget.searchData = (searchData == null) ? '' : searchData;
//               });
//             },
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             // _buildFilterBar(), //TODO - Temporarily hidden
//             UIHelper.verticalSpaceSmall(),
//             Expanded(child: SearchCourseListPage(courses: widget.courses)),
//           ],
//         ),
//       ),
//     );
//   }

//   Container _buildFilterBar() => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10.0),
//         height: 50.0,
//         child: Row(
//           children: <Widget>[
//             Text('13,057 Courses'),
//             Spacer(),
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) => SizedBox(
//                     height: context.mediaQuerySize().width / 0.7,
//                     child: SortFilterPage(),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: 35.0,
//                 width: 90.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: context.theme().accentColor, width: 2.0),
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     UIHelper.horizontalSpaceSmall(),
//                     Icon(
//                       Icons.filter_list,
//                       color: context.theme().accentColor,
//                       size: 20.0,
//                     ),
//                     UIHelper.horizontalSpaceSmall(),
//                     Text(
//                       'Filter',
//                       style: TextStyle(
//                         color: context.theme().accentColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
// }
