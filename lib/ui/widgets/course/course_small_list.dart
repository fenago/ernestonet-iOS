import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/models/course_category.dart';
import 'course_card_title.dart';
import 'course_card_item.dart';

class CourseSmallList extends StatelessWidget {
  final CourseCategory courseCategory;
  final double cardListViewHeight;

  const CourseSmallList({
    Key key,
    @required this.courseCategory,
    this.cardListViewHeight = 240.0,
  })  : assert(courseCategory != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardListViewHeight,
      child: Column(
        children: <Widget>[
          CourseCardTitle(title: courseCategory.title),
          if (courseCategory.courses != null)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courseCategory.courses.length,
                itemBuilder: (context, index) => (courseCategory.courses.length > 9 && index == 9)
                    ? InkWell(
                        onTap: () {
                          print('see all tapped');
                          final Map<String, dynamic> data = {
                            'id': courseCategory.id,
                            'name': courseCategory.title,
                          };
                          Navigator.pushNamed(context, ViewRoutes.categoryDetail, arguments: data);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 170.0,
                          child: Text(
                            'See all',
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Palette.appColor,
                            ),
                          ),
                        ),
                      )
                    : CourseCardItem(
                        course: courseCategory.courses[index],
                        cardWidth: 170.0,
                        imageHeight: 95.0,
                      ),
              ),
            )
        ],
      ),
    );
  }
}
