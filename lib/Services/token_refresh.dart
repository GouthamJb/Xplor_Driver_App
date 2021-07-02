import 'dart:convert';
import 'package:http/http.dart';
import '/Configs/paths.dart';
import '/Services/cache_services.dart';

class TokenRefresh {
  String url = Paths.serverUrl + Paths.tokenRefreshPath;
  String refreshToken;
  Map response;
  bool isTokenValid;

  TokenRefresh();

  Future<void> refresh() async {
    refreshToken = await CacheService().getRefreshToken();
    try {
      Response res =
          await post(Uri.parse(url), body: {"refresh": refreshToken});

      print(res.statusCode);
      print(res.body);

      response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        await CacheService()
            .writeStringToCache('accessToken', response['access']);

        //await CacheService()
        //.writeStringToCache('refreshToken', response!['refresh']);
        isTokenValid = true;
      } else {
        isTokenValid = false;
      }
    } catch (e) {
      isTokenValid = false;
      print('Something went wrong while token refresh. Error: $e');
    }
  }

  bool isRefreshTokenValid() {
    print("hit: " + isTokenValid.toString());
    return isTokenValid;
  }
}
