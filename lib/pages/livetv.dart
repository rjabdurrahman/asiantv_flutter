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
import 'package:better_player/better_player.dart';

class LiveTV extends StatefulWidget {

  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  BetterPlayerController _betterPlayerController;
  YoutubePlayerController _controller;
  String LiveVideoURL;
  List<ModelVideos> recentVideos;


  bool _loading;
  bool _loadingRecent = true;
  @override
  void initState() {
    _loading = true;

    //Batter player controller

    // Getting data from the server
    ServiceLive.getLiveUrl().then((url) {
      // _liveurl = url;
      // LiveVideoURL = url[0].url;
      LiveVideoURL = url[0].url;
      // Live Video Player Configuration
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.NETWORK,LiveVideoURL);
      _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: true,
            looping: true,
            allowedScreenSleep: false,
            fullScreenByDefault: false,
          ),
          betterPlayerDataSource: betterPlayerDataSource);

      // print( "Url from the cloud Json -----------------------------------: " + url[0].url);
      setState(() {
        _loading = false;
      });
      // Getting recent videos
      ServiceRecentVideos serviceRecentVIDEOS =
          new ServiceRecentVideos('news', 10);
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

    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _betterPlayerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
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
                  : BetterPlayer(
                      controller: _betterPlayerController,
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                flex: 6,
                child: _loadingRecent
                    ? Shimmer.fromColors(
                        child: GridView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0,
                                    childAspectRatio: 2.7),
                            itemBuilder: (context, index) => Material(
                                  //  Starting creating widget for recent videos
                                  color: Colors.white,
                                  elevation: 14.0,
                                  borderRadius: BorderRadius.circular(24.0),
                                  shadowColor: Color(0x802196F3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Loading.."),
                                      )
                                    ],
                                  ),
                                )),
                        baseColor: Colors.grey,
                        highlightColor: Colors.redAccent)
                    //After Getting data
                    : InkWell(
                        onTap: () {
                          // If any click occurs in recent videos playlist stop live playback
                          _betterPlayerController.pause();
                        },
                        child: RecentVideos(recentVideos),
                      ))
          ],
        ),
      ),
    );
  }
}

