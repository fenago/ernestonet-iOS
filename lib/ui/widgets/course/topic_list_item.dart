import 'package:edustar/core/constants/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';
import '../../shared/ui_helper.dart';

class TopicListItem extends StatelessWidget {
  final String title;
  final String duration;
  final bool currentlyPlaying;
  final VoidCallback onDownloadPressed;

  TopicListItem({
    @required this.title,
    @required this.duration,
    @required this.currentlyPlaying,
    @required this.onDownloadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.play_circle_filled, size: 16.0, color: currentlyPlaying ? Colors.green : Colors.grey),
          UIHelper.horizontalSpaceMedium(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: context.textTheme().subtitle1.copyWith(fontSize: 15.0, fontWeight: FontWeight.normal)),
              UIHelper.verticalSpaceSmall(),
              Row(
                children: <Widget>[
                  Icon(Icons.closed_caption, size: 18.0, color: Colors.grey),
                  UIHelper.horizontalSpaceSmall(),
                  Text('Video - ' + duration, style: TextStyle(color: Colors.grey[700])),
                ],
              )
            ],
          ),
          // TODO: Download button hidden temporarily
          // Spacer(),
          // currentlyPlaying
          //     ? Stack(
          //         children: [
          //           CircularProgressIndicator(),
          //           Align(
          //             alignment: Alignment.center,
          //             child: Text('42%'),
          //           )
          //         ],
          //       )
          //     : InkWell(
          //         child: Icon(Icons.file_download, color: Colors.grey),
          //         onTap: onDownloadPressed,
          //       )
        ],
      ),
    );
  }
}
