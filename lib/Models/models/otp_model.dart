import 'dart:convert';
import 'package:http/http.dart';
import '/Configs/paths.dart';
import '/Services/cache_services.dart';

class OtpModal {
  String mobile, otp;
  String url = Paths.serverUrl + Paths.otpPath;
  Map response, userDetails;
  String refreshToken, accessToken;

  OtpModal({this.mobile, this.otp});

  Future<bool> sendOtp() async {
    try {
      Response res = await post(Uri.parse(url),
          body: {"username": "DR_" + mobile, "password": otp});

      print(res.statusCode);
      print(res.body);

      response = jsonDecode(res.body);

      accessToken = response['response']['access'];
      refreshToken = response['response']['refresh'];

      userDetails = response['response']['user'];

      if (res.statusCode == 200) {
        CacheService cacheService = new CacheService();
        cacheService.writeStringToCache('accessToken', accessToken);
        cacheService.writeStringToCache('refreshToken', refreshToken);
        cacheService.writeStringToCache('userDetails', jsonEncode(userDetails));

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Caught error : $e');
      response = {
        'success': false,
        'details': {'message': 'Something went wrong!'}
      };
      return false;
    }
  }

  Map getResponse() {
    Map result = {
      'success': response['success'],
      'message': response['details']['message']
    };

    return result;
  }
}
