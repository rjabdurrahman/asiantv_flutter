import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  final String VideoURL;

  VideoPlayer({Key key, @required this.VideoURL}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _controller;


  void initState() {
    // TODO: implement initState
    super.initState();
    // Change screen orientation to Landscape
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // Hide Notification bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // Setup youtube player config
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.VideoURL),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        hideControls: false,
        hideThumbnail: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.pause();
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        body: YoutubePlayer(
          controller: _controller,
          onReady: () => {_controller.toggleFullScreenMode()},
        ),
      ),
    );
  }
}
