import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../core/models/course/course.dart';
import '../../../core/view_models/custom_video_player_view_model.dart';
import '../../../core/view_models/video_player_timer_view_model.dart';
import '../../pages/base_view.dart';
import '../../shared/ui_helper.dart';
import '../thumbnail_overlay.dart';

enum SeekType { backward, forward }

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Course course;
  final VoidCallback fullScreenPressed;
  bool toUpdate = false;
  bool isNewVideo = false;

  CustomVideoPlayer({
    Key key,
    @required this.videoUrl,
    @required this.course,
    this.fullScreenPressed,
    this.toUpdate,
    this.isNewVideo,
  })  : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);
  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    print('PLayer 📹 Video URL : ${widget.videoUrl}');
    print('UPDATE VIDEO ?? : ${widget.toUpdate}');
    print('IS NEW VIDEO ?? : ${widget.isNewVideo}');

    return ChangeNotifierProvider<VideoPlayerTimerViewModel>(
      create: (context) => VideoPlayerTimerViewModel(),
      builder: (context, _) => BaseView<CustomVideoPlayerViewModel>(
        model: CustomVideoPlayerViewModel(),
        onModelReady: (model) {
          if (!widget.toUpdate) {
            print('NEW VIDEO');
            _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
          }
        },
        builder: (_, model, __) {
          if (widget.toUpdate && widget.isNewVideo) {
            print('🎥 FINAL UPDATE VIDEO : ${widget.videoUrl}');
            _videoPlayerController.dispose();
            _videoPlayerController = null;
            _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
            model.startVideo(_videoPlayerController, context.read<VideoPlayerTimerViewModel>());
            widget.toUpdate = false;
          }

          return RotatedBox(
            quarterTurns: model.isFullScreen ? 1 : 0,
            child: Container(
              color: Colors.black,
              width: double.infinity,
              child: (model.isFirstTimePlaying)
                  ? ThumbnailOverlay(
                      course: widget.course,
                      showProgress: model.isLoading,
                      fullScreen: model.isFullScreen,
                      onPlayPressed: () {
                        model.startVideo(_videoPlayerController, context.read<VideoPlayerTimerViewModel>(), isFirstTime: true);
                      })
                  : (model.isLoading)
                      ? PlayerLoadingView()
                      : PlayerView(
                          controller: _videoPlayerController,
                          onFullScreenPressed: widget.fullScreenPressed,
                        ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}

class PlayerLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          Platform.isIOS
              ? Positioned(
                  top: 2.0,
                  left: 1.0,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: Colors.white,
                    ),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class PlayerView extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onFullScreenPressed;

  const PlayerView({
    Key key,
    @required this.controller,
    @required this.onFullScreenPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        VideoPlayer(controller),
        _PlayerOverlayView(
          videoPlayerController: controller,
          onFullScreenPressed: onFullScreenPressed,
        ),
      ],
    );
  }
}

class _PlayerOverlayView extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final VoidCallback onFullScreenPressed;

  const _PlayerOverlayView({
    Key key,
    @required this.videoPlayerController,
    @required this.onFullScreenPressed,
  }) : super(key: key);

  @override
  _PlayerOverlayViewState createState() => _PlayerOverlayViewState();
}

class _PlayerOverlayViewState extends State<_PlayerOverlayView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => context.read<CustomVideoPlayerViewModel>().toggleOverlay(),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: context.watch<CustomVideoPlayerViewModel>().showOverlayView
              ? InkWell(
                  onTap: () => context.read<CustomVideoPlayerViewModel>().toggleOverlay(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black54,
                    child: Stack(
                      children: <Widget>[
                        Platform.isIOS
                            ? Positioned(
                                top: 2.0,
                                left: 1.0,
                                child: IconButton(
                                    icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Colors.white),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      if (context.read<CustomVideoPlayerViewModel>().isFullScreen) {
                                        context.read<CustomVideoPlayerViewModel>().toggleFullScreenMode();
                                        widget.onFullScreenPressed();
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    }),
                              )
                            : SizedBox(),
                        _buildPlayPauseView(),
                        // _buildBottomControlsView(),
                        _BottomControlsView(
                          videoPlayerController: widget.videoPlayerController,
                          onPressedFullScreen: widget.onFullScreenPressed,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Positioned _buildPlayPauseView() => Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 50.0,
                icon: Icon(Icons.replay_10, color: Colors.white),
                onPressed: () => context.read<CustomVideoPlayerViewModel>().seekTo(SeekType.backward, widget.videoPlayerController),
              ),
              UIHelper.horizontalSpaceSmall(),
              IconButton(
                iconSize: 50.0,
                icon: Icon(
                  widget.videoPlayerController.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_filled,
                  color: Colors.white,
                ),
                onPressed: () => widget.videoPlayerController.value.isPlaying
                    ? context.read<CustomVideoPlayerViewModel>().pause(widget.videoPlayerController)
                    : context.read<CustomVideoPlayerViewModel>().play(widget.videoPlayerController),
              ),
              UIHelper.horizontalSpaceSmall(),
              IconButton(
                iconSize: 50.0,
                icon: Icon(Icons.forward_10, color: Colors.white),
                onPressed: () => context.read<CustomVideoPlayerViewModel>().seekTo(SeekType.forward, widget.videoPlayerController),
              ),
            ],
          ),
        ),
      );
}

class _BottomControlsView extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  final VoidCallback onPressedFullScreen;

  const _BottomControlsView({
    Key key,
    @required this.videoPlayerController,
    @required this.onPressedFullScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5.0,
      left: 15.0,
      right: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Consumer<VideoPlayerTimerViewModel>(
            builder: (context, model, _) => Text(
              model.currentPosition,
              style: TextStyle(color: Colors.white),
            ),
          ),
          UIHelper.horizontalSpaceSmall(),
          Expanded(
            child: VideoProgressIndicator(
              videoPlayerController,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              allowScrubbing: true,
              colors: VideoProgressColors(playedColor: Colors.red),
            ),
          ),
          UIHelper.horizontalSpaceSmall(),
          Consumer<VideoPlayerTimerViewModel>(
            builder: (context, model, _) => Text(
              model.duration,
              style: TextStyle(color: Colors.white),
            ),
          ),
          UIHelper.horizontalSpaceSmall(),
          InkWell(
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: 30.0,
            ),
            splashColor: Colors.green,
            onTap: () {
              context.read<CustomVideoPlayerViewModel>().toggleFullScreenMode();
              onPressedFullScreen();
            },
          ),
        ],
      ),
    );
  }
}
