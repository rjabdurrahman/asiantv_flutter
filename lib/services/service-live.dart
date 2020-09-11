import 'package:http/http.dart' as http;
import '../models/model-live.dart';
import '../constants/urls.dart' as URLConstants;

class ServiceLive {
  static const String url = URLConstants.APIBaseURL  + "/free/live/live.php";

  static Future<List<ModelLive>> getLiveUrl() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<ModelLive> liveurl = modelLiveFromJson(response.body);
        return liveurl;
      } else {
        return List<ModelLive>();
      }
    } catch (e) {
      return List<ModelLive>();
    }
  }
}
