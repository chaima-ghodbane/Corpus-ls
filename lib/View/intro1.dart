import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


void main() {
  return runApp( MaterialApp(
    home: ResizedVideo(videoUrl:'https://www.youtube.com/watch?v=CUy9Dos9264',),
  ));
}

class ResizedVideo extends StatefulWidget {
  final String videoUrl;

  ResizedVideo({required this.videoUrl});

  @override
  _ResizedVideoState createState() => _ResizedVideoState();
}

class _ResizedVideoState extends State<ResizedVideo> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl);
    _videoController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoController.value.isInitialized) {
      return Container();
    }

    final videoSize = _videoController.value.size;
    final aspectRatio = videoSize.width / videoSize.height;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: VideoPlayer(_videoController),
        ),
      ),
    );
  }
}