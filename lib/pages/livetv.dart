import 'package:flutter/material.dart';
import 'package:tv_app/models/model-live.dart';
import 'package:tv_app/services/service-live.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart' as ColorConstants;

import 'HomePage.dart' as home;
import 'fullscreenlivetv.dart';

class LiveTV extends StatefulWidget {
  // Live Stream link = https://www.youtube.com/watch?v=uipWBdYp2gY

  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  YoutubePlayerController _controller;
  String LiveVideoURL;

  // List<ModelLive> _liveurl;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    // Getting data from the server
    ServiceLive.getLiveUrl().then((url) {
      // _liveurl = url;
      LiveVideoURL = url[0].url;
      // print( "Url from the cloud Json -----------------------------------: " + url[0].url);
      setState(() {
        _loading = false;
      });

      // Player Related Configuration
      // Configuring youtube player
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(LiveVideoURL),
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          hideControls: true,
          loop: false,
          isLive: true,
          forceHD: false,
          enableCaption: true,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: _loading
                ? Text("Getting video url")
                : YoutubePlayer(
                    controller: _controller,
                    onReady: () => {
                      _controller.value.isFullScreen
                          ? print("Player is now full Screen")
                          : print("Player in now small Screen")
                    },
                  ),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              child: Text("Full Screen"),
              onPressed: () async {
                _controller.pause();
                var result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      LiveTVFullScreen(LiveVideoUrl: LiveVideoURL),
                ));
                if (result == true) {
                  print("Navigation Back event occured!");
                  if (MediaQuery.of(context).orientation ==
                      Orientation.landscape) {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                  }
                  _controller.play();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
