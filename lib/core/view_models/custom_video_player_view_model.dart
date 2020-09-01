import 'package:edustar/core/view_models/video_player_timer_view_model.dart';
import 'package:video_player/video_player.dart';

import '../../ui/widgets/course/custom_video_player.dart';
import '../utils/duration_helper.dart';
import 'base_view_model.dart';

class CustomVideoPlayerViewModel extends BaseViewModel {
  bool isVideoInitialized = false;
  bool isLoading = false;
  bool isFullScreen = false;
  bool showOverlayView = false;
  bool isFirstTimePlaying = true;
  String currentPosition = '';
  String duration = '';

  CustomVideoPlayerViewModel();

  void startVideo(VideoPlayerController videoPlayer, VideoPlayerTimerViewModel timerModel, {bool isFirstTime = false}) {
    isLoading = true;
    if (isFirstTime) {
      notifyListeners();
    }
    videoPlayer.addListener(() {
      if (showOverlayView) {
        updateDuration(videoPlayer, timerModel);
      }
    });
    videoPlayer.setLooping(false);
    videoPlayer.initialize().then((_) => {
          isFirstTimePlaying = false,
          setVideoInitializeStatus(true, videoPlayer),
        });
  }

  void toggleFullScreenMode() {
    isFullScreen = !isFullScreen;
    notifyListeners();
  }

  void setVideoInitializeStatus(bool status, VideoPlayerController videoPlayer) {
    isLoading = false;
    isVideoInitialized = status;
    play(videoPlayer);
    notifyListeners();
  }

  void pause(VideoPlayerController videoPlayer) {
    if (videoPlayer.value.isPlaying) {
      videoPlayer.pause();
      showOverlayView = false;
      notifyListeners();
    }
  }

  void play(VideoPlayerController videoPlayer) {
    videoPlayer.play();

    // Video ended
    if (videoPlayer.value.position == videoPlayer.value.duration) {
      videoPlayer.seekTo(Duration(seconds: 0));
    }
    showOverlayView = false;
    notifyListeners();
  }

  void seekTo(SeekType type, VideoPlayerController videoPlayer) {
    videoPlayer.position.then((position) {
      videoPlayer.seekTo(
        Duration(
          seconds: type == SeekType.forward ? position.inSeconds + 10 : position.inSeconds - 10,
        ),
      );
    });
  }

  void updateDuration(VideoPlayerController videoPlayer, VideoPlayerTimerViewModel timerViewModel) async {
    if (videoPlayer.value?.duration != null && videoPlayer.value.isPlaying) {
      duration = formatDuration(videoPlayer.value.duration);
      final position = await videoPlayer.position;
      final currentPosition = formatDuration(position);
      timerViewModel.updateTimer(duration, currentPosition);
    }
  }

  void toggleOverlay() {
    showOverlayView = !showOverlayView;
    notifyListeners();
  }
}
