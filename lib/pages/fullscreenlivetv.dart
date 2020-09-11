import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class LiveTVFullScreen extends StatefulWidget {
  final String LiveVideoUrl;

  LiveTVFullScreen({Key key, @required this.LiveVideoUrl}) : super(key: key);

  @override
  _LiveTVFullScreenState createState() => _LiveTVFullScreenState();
}

class _LiveTVFullScreenState extends State<LiveTVFullScreen> {
  YoutubePlayerController _controller;


  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.LiveVideoUrl),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        hideControls: true,
        hideThumbnail: true,
        loop: false,
        isLive: true,
        forceHD: false,
        enableCaption: true,
      ),
    );
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
