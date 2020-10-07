import 'package:flutter/material.dart';
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
          ? Text('Loading..' + widget.categoryName)
          : RecentVideos(videos),
    );
  }
}