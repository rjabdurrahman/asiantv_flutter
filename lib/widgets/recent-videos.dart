import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tv_app/models/model-videos.dart';
import 'package:tv_app/pages/live-video.dart';
import 'package:tv_app/widgets/VideoDetails.dart';
import 'package:tv_app/widgets/message-box.dart';

class RecentVideos extends StatefulWidget {
  RecentVideos(this.recentVideos);
  List<ModelVideos> recentVideos;

  @override
  _RecentVideosState createState() => _RecentVideosState();
}

class _RecentVideosState extends State<RecentVideos> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print('Scrolled');
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        // Load Next
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.recentVideos.length < 1
            ? MessageBox(
                Icons.info_outline, Colors.grey, "No Recent Videos Availabe")
            : ListView.builder(
                itemCount: widget.recentVideos.length,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: SizedBox(
                          height: 120,
                          child: InkWell(
                            onTap: () async {
                              {
                                var result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => VideoPlayer(
                                      VideoURL:
                                          widget.recentVideos[index].link),
                                ));
                                if (result == true) {
                                  print("Navigation Back event occurred!");
                                  if (MediaQuery.of(context).orientation ==
                                      Orientation.landscape) {
                                    SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.portraitUp]);
                                  }
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(24.0),
                                    child: Container(
                                      width: 180,
                                      height: 130,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(widget
                                                  .recentVideos[index]
                                                  .thumbnail),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 6,
                                  fit: FlexFit.loose,
                                  child: Container(
                                    //Here will be details widget
                                    child: VideoDetails(
                                        widget.recentVideos[index].title,
                                        widget.recentVideos[index].createdAt
                                            .toIso8601String(),
                                        widget.recentVideos[index].likes,
                                        widget.recentVideos[index].length),
                                  ),
                                ),
                                //  Image Container
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
