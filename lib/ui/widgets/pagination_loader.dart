import 'package:flutter/material.dart';

class PaginationLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 60.0,
      child: CircularProgressIndicator(),
    );
  }
}
