import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/constants/api_routes.dart';
import 'package:edustar/core/constants/asset_images.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:edustar/core/view_models/custom_video_player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course/custom_video_player.dart';

class ThumbnailOverlay extends StatelessWidget {
  final Course course;
  final bool showProgress;
  final bool fullScreen;
  final VoidCallback onPlayPressed;

  const ThumbnailOverlay({
    Key key,
    @required this.course,
    @required this.showProgress,
    @required this.fullScreen,
    @required this.onPlayPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            height: double.infinity,
            width: double.infinity,
            imageUrl: (course.image != null) ? course.image : ApiRoutes.mediaBaseUrl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          showProgress
              ? PlayerLoadingView()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black38,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                            ),
                            iconSize: 50.0,
                            onPressed: onPlayPressed,
                          ),
                        ),
                      ),
                      Platform.isIOS
                          ? Positioned(
                              top: 2.0,
                              left: 1.0,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Colors.white),
                                iconSize: 30.0,
                                onPressed: () {
                                  if (fullScreen) {
                                    context.read<CustomVideoPlayerViewModel>().toggleFullScreenMode();
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
