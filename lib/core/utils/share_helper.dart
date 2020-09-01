import 'package:flutter/material.dart';
import 'package:share/share.dart';

void share(BuildContext context, String text) {
  final RenderBox box = context.findRenderObject();
  Share.share(
    text,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
