import 'package:flutter/material.dart';

class CourseListProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 110.0,
      child: SizedBox(height: 20.0, width: 20.0, child: CircularProgressIndicator()),
    );
  }
}
