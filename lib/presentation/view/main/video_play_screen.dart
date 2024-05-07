
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: false,
        disableDragSeek: false,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: controller,
        progressIndicatorColor: Colors.deepPurpleAccent,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
            backgroundColor: Colors.deepPurpleAccent,
            bufferedColor: Colors.black45,
            playedColor: Colors.red),
        bottomActions: [
          CurrentPosition(
            controller: controller,
          ),
          ProgressBar(
            controller: controller,
            isExpanded: true,
            colors: const ProgressBarColors(
                backgroundColor: Colors.deepPurpleAccent,
                bufferedColor: Colors.black45),
          ),
          FullScreenButton(
            controller: controller,
            color: Colors.white,
          ),
          // PlaybackSpeedButton(
          //   controller: controller,
          //   icon: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          // ),
          // IconButton(
          //     onPressed: () {
          //       controller.seekTo(
          //           (controller.value.position + const Duration(seconds: 10)));
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     )),
          // IconButton(
          //     onPressed: () {
          //       print('buffer ${controller.value.buffered}');
          //       print('position ${controller.value.position}');
          //       print(' Playback Rate ${controller.value.playbackRate}');
          //       print('metadata ${controller.metadata.duration}');
          //       // controller.seekTo((controller.value.position-const Duration(seconds: 10)));
          //     },
          //     icon: Icon(
          //       Icons.mic,
          //       color: Colors.white,
          //     )),
          // IconButton(
          //     onPressed: () {
          //       controller.toggleFullScreenMode();
          //     },
          //     icon: Icon(
          //       Icons.fullscreen,
          //       color: Colors.white,
          //     )),


        ],
      ),
    );
  }
}

