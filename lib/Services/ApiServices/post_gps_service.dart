import '/Models/models/gps_model.dart';
import '../general_api_service.dart';

class GpsService {
  GpsService();
  Future<GpsPost> fetchFromRemote(var body) async {
    ApiService apiService = new ApiService();
    final isSucces = await apiService.postRequests('/api/gps/',body);
    final jsonResponse = apiService.getResponse();
    if (isSucces) {
     GpsPost result = GpsPost.fromJson(jsonResponse);
      return result;
    } else {
      Details det = new Details(message: jsonResponse['details']['message']);
      GpsPost result = new GpsPost(success: jsonResponse['success'], details: det);
      return result;
    }
  }
}
