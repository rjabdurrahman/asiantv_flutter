import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tv_app/models/model-videos.dart';
import 'package:tv_app/services/service-live.dart';
import 'package:tv_app/widgets/VideoDetails.dart';
import 'package:tv_app/widgets/recent-videos.dart';
import 'package:tv_app/widgets/video-thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
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
            Expanded(
              flex: 5,
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
                                  size: 110,
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
                      highlightColor: Colors.white)
                  : YoutubePlayer(
                      controller: _controller,
                      onReady: () => {
                        //  TODO: Youtube player is ready for playing
                      },
                    ),
            ),
            Expanded(
              flex: 2,
              child: _loading
                  ? Text("")
                  : FittedBox(
                    child: Column(
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
                                    print("Navigation Back event occurred!");
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
                        SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
            ),
            Expanded(
              flex: 6,
              child: _loadingRecent?
              Shimmer.fromColors(
                child: GridView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 2.7
                    ),
                    itemBuilder: (context, index) => Material(
                    //  Starting creating widget for recent videos
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Container(
                              child: Text("Loading.."),
                            )
                        ],
                      ),
                    )

                ),
                  baseColor: Colors.grey,
                  highlightColor: Colors.redAccent
              )
                  //After Getting data
                  : RecentVideos(recentVideos)

            )
          ],
        ),
      ),
    );
  }
}


// VideoThumbnailViewer(recentVideos[index].thumbnail, recentVideos[index].link),
// VideoDetails(recentVideos[index].title, recentVideos[index].createdAt.toIso8601String(), recentVideos[index].likes, recentVideos[index].length)
Widget myDetailsContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(child: Text("Chocolate Haven",
          style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(child: Row(children: <Widget>[
          Container(child: Text("4.3",
            style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
          Container(child: Icon(
            FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
          Container(child: Icon(
            FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
          Container(child: Icon(
            FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
          Container(child: Icon(
            FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
          Container(child: Icon(
            FontAwesomeIcons.solidStarHalf, color: Colors.amber,
            size: 15.0,),),
          Container(child: Text("(75) \u00B7 1.2 mi",
            style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
        ],)),
      ),
      Container(child: Text("Pastries \u00B7 Phoenix,AZ",
        style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
    ],
  );
}
