import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoComponent extends StatefulWidget {
  const VideoComponent({super.key});

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset("assets/videos/nature.mp4");
    loadvideo();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false);
    setState(() {});
  }

  Future<void> loadvideo() async {
    await videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: Chewie(controller: chewieController),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              IconButton(
                  color: Colors.green,
                  onPressed: () async {
                    await videoPlayerController.play();
                  },
                  icon: Icon(Icons.play_arrow)),
              IconButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await videoPlayerController.pause();
                  },
                  icon: Icon(Icons.pause)),
            ],
          )
        ],
      ),
    );
  }
}
