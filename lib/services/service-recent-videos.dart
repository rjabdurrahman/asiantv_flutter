import 'package:http/http.dart' as http;
import '../models/model-videos.dart';
import '../constants/urls.dart' as URLConstants;

class ServiceRecentVideos {
  ServiceRecentVideos(this.categoryName, this.total);

  static const String baseURL = URLConstants.APIBaseURL;
  String categoryName;
  int total;

  Future<List<ModelVideos>> getLiveUrl() async {
    String url = baseURL +
        "/free/recent/getrecent.php?cname=" +
        categoryName +
        "&total=" +
        total.toString();
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<ModelVideos> liveurl = modelVideosFromJson(response.body);
        return liveurl;
      } else {
        return List<ModelVideos>();
      }
    } catch (e) {
      return List<ModelVideos>();
    }
  }
}
