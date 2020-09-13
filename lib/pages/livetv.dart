import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tv_app/models/model-videos.dart';
import 'package:tv_app/services/service-live.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import '../services/service-recent-videos.dart';

import 'fullscreenlivetv.dart';

class LiveTV extends StatefulWidget {
  // Live Stream link = https://www.youtube.com/watch?v=uipWBdYp2gY

  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  YoutubePlayerController _controller;
  String LiveVideoURL;
  List<ModelVideos> recentVideos;

  // List<ModelLive> _liveurl;
  bool _loading;
  bool _loadingRecent = true;
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
      // Getting recent videos
      ServiceRecentVideos serviceRecentVIDEOS =
          new ServiceRecentVideos('music', 10);
      print(
          "Working on recent videos ---------------------------------------------------");
      serviceRecentVIDEOS.getLiveUrl().then((results) {
        setState(() {
          this.recentVideos = results;
          _loadingRecent = false;
        });
        print(
            "Recent Videos Length --------------------------------------------------: " +
                results.length.toString());
        print(
            "First Item Title: ------------------------------------------------------:" +
                results[0].title);
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
          loop: true,
          hideThumbnail: true,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: _loading
                  ? Shimmer.fromColors(
                      child: SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Colors.red,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.red,
                                  size: 160,
                                ),
                                Text("Live TV",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                        height: 265,
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.redAccent)
                  : YoutubePlayer(
                      controller: _controller,
                      onReady: () => {
                        //  TODO: Youtube player is ready for playing
                      },
                    ),
            ),
            Flexible(
              flex: 1,
              child: _loading
                  ? Text("")
                  : Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_arrow, color: Colors.white),
                                  Text(
                                    "Play",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () => {_controller.play()},
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            RaisedButton(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.stop, color: Colors.white),
                                  Text(
                                    "Pause",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () => {_controller.pause()},
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            RaisedButton(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.fullscreen, color: Colors.white),
                                  Text(
                                    "Full Screen",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () async {
                                _controller.pause();
                                var result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => LiveTVFullScreen(
                                      LiveVideoUrl: LiveVideoURL),
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
                            )
                          ],
                        ),

                    ],
                  ),
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 2,
            ),
            Flexible(
              flex: 6,
              child: _loadingRecent?
              Shimmer.fromColors(
                child: GridView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 2.5
                    ),
                    itemBuilder: (context, index) => Container(
                      color: Colors.grey,
                      child: Center(
                          child: Text(
                            "Loading Recent Video",
                            style: TextStyle(fontSize: 24.0, color: Colors.white),
                          )),
                    )),
                  baseColor: Colors.grey,
                  highlightColor: Colors.redAccent
              )
                  //After Getting data
                  :
              GridView.builder(
                  //This is the builder where we are going to show recent videos
                  itemCount: recentVideos.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 2.5
                  ),
                  itemBuilder: (context, index) => ListTile(
                    leading: Image.network(recentVideos[index].thumbnail),
                    title: Text(recentVideos[index].title),
                    // trailing: Text(recentVideos[index].createdAt.toIso8601String())
                  )),
            )
          ],
        ),
      ),
    );
  }
}
