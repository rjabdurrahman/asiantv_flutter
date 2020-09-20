import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class VideoDetails extends StatefulWidget {
  VideoDetails(this.title, this.publishedAt, this.likes, this.length);
  String title;
  String length;
  String publishedAt;
  String likes;

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  String hourLength;
  var parsedDate;

  // Converting hour to min. If min is larger or equal to 60
  mintToHour() {
    if (double.tryParse(widget.length) >= 60) {
      setState(() {
        hourLength =
            (double.tryParse(widget.length) / 60).toStringAsFixed(2) + " hour";
      });
    } else {
      setState(() {
        hourLength = widget.length + " min";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mintToHour();
    setState(() {
      parsedDate = DateTime.parse(widget.publishedAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.title.length > 25
                  ? widget.title.substring(1, 25) + "..."
                  : widget.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xffe6020a),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 4.0),
          child: Container(
              child: Text(
            hourLength,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
          child: Container(
              child: Text(
            widget.likes + " Likes",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
          child: Container(
              child: Text(
            timeago.format(parsedDate).toString(),
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          )),
        ),
      ],
    );
  }
}
