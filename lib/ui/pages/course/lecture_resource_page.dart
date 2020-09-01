import 'package:edustar/ui/shared/app_style.dart';
import 'package:flutter/material.dart';

class LectureResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Resources', style: appBarTheme),
      ),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text('05.01-create android studio project.zip'),
          subtitle: Text('File - 44.2kb'),
          onTap: () {
            print('download file');
          },
        ),
      ),
    );
  }
}
