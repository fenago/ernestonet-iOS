import 'package:edustar/core/constants/view_routes.dart';
import 'package:edustar/ui/shared/app_style.dart';
import 'package:flutter/material.dart';

class CourseResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Resources', style: appBarTheme),
      ),
      body: ListView.separated(
        itemCount: 30,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text('Lecture ${index + 1} - Creating a flutter project with Android Studio'),
          subtitle: Text('1 resource'),
          onTap: () {
            Navigator.pushNamed(context, ViewRoutes.lectureResources);
          },
        ),
      ),
    );
  }
}
