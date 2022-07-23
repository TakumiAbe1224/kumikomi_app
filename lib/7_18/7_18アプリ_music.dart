import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/famipop3.mp3');
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: Text("音楽再生"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.music_video, size: 256),
          ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _controller
                      .seekTo(Duration.zero)
                      .then((_) => _controller.play());
                },
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  _controller.play();
                },
                icon: Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  _controller.pause();
                },
                icon: Icon(Icons.pause),
              ),
            ],
          ),
        ],
      ),
    );
  }
}