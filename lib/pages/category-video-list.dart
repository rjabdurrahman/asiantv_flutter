import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tv_app/models/model-videos.dart';
import 'package:tv_app/services/service-video.dart';
import 'package:tv_app/widgets/recent-videos.dart';

class CategoryVideoList extends StatefulWidget {
  final String categoryName;
  CategoryVideoList({Key key, @required this.categoryName}) : super(key: key);

  @override
  _CategoryVideoListState createState() => _CategoryVideoListState();
}

class _CategoryVideoListState extends State<CategoryVideoList> {
  List<ModelVideos> videos;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    ServiceVideos serviceVideo = new ServiceVideos(widget.categoryName, 1);
    serviceVideo.getVideos().then((results) {
      setState(() {
        this.videos = results;
        _loading = false;
      });
      print(
          "Recent Videos Length --------------------------------------------------: " +
              results.length.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _loading
          ? Shimmer.fromColors(
              child: GridView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:
                                  Text(widget.categoryName + " is Loading.."),
                            )
                          ],
                        ),
                      )),
              baseColor: Colors.grey,
              highlightColor: Colors.redAccent)
          : RecentVideos(videos),
    );
  }
}
