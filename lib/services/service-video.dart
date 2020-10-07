import 'package:http/http.dart' as http;
import '../models/model-videos.dart';
import '../constants/urls.dart' as URLConstants;

class ServiceVideos {
  ServiceVideos(this.categoryName, this.page);

  static const String baseURL = URLConstants.APIBaseURL;
  String categoryName;
  int page;

  Future<List<ModelVideos>> getVideos() async {
    String url = baseURL +
        "/free/pagination/getVideosListByPagination.php?cname=" +
        categoryName +
        "&page=" +
        page.toString();
    print('------------Consuming URL' + url);
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
