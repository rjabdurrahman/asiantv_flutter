
import 'package:flutter/material.dart';

class VideoThumbnailViewer extends StatelessWidget {
  VideoThumbnailViewer(this.thumbnailURL, this.VideoURL);

  String thumbnailURL;
  String VideoURL;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:115,
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: new BorderRadius.circular(24.0),
            child: Image(
              fit: BoxFit.fill,
              alignment: Alignment.topLeft,
              image: NetworkImage(this.thumbnailURL),
            ),
          ),
        ],
      ),
    );
  }
}

