import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tv_app/models/model-videos.dart';
import 'package:tv_app/pages/live-video.dart';
import 'package:tv_app/widgets/VideoDetails.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecentVideos extends StatefulWidget {


  RecentVideos(this.recentVideos);
  List<ModelVideos> recentVideos;

  @override
  _RecentVideosState createState() => _RecentVideosState();
}

class _RecentVideosState extends State<RecentVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.recentVideos.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child:  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 4,
                          child: InkWell(
                            onTap: () async {
                              var result = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => VideoPlayer(
                                    VideoURL: widget.recentVideos[index].link),
                              ));
                              if (result == true) {
                                print("Navigation Back event occurred!");
                                if (MediaQuery.of(context).orientation ==
                                    Orientation.landscape) {
                                  SystemChrome.setPreferredOrientations(
                                      [DeviceOrientation.portraitUp]);
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Container(
                                width: 150,
                                height: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.recentVideos[index].thumbnail),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 6,
                          fit: FlexFit.loose,
                          child: Container(
                            //Here will be details widget
                            child: VideoDetails(widget.recentVideos[index].title, widget.recentVideos[index].createdAt.toIso8601String(), widget.recentVideos[index].likes, widget.recentVideos[index].length),
                          ),
                        ),
                        //  Image Container

                      ],
                    ),
                  ),
                ),
              ),
            );
      }
      )
    );
  }
}
