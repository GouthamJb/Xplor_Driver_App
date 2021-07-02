import 'package:http/http.dart';
import 'package:xplor_driver_app/Configs/paths.dart';
import 'package:xplor_driver_app/Services/cache_services.dart';
import 'package:xplor_driver_app/Services/token_refresh.dart';

class CheckAuth {
  CheckAuth();

  Future<bool> checkUserAuth() async {
    if (await CacheService().isKeyExists("accessToken")) {
      String accessToken = await CacheService().getAccessToken();
      String url = Paths.serverUrl + Paths.authAccessPath;

      TokenRefresh tokenRefresh = new TokenRefresh();

      Response response = await get(Uri.parse(url),
          headers: {"Authorization": "Bearer " + accessToken});

      if (response.statusCode == 200) {
        return true;
      } else {
        await tokenRefresh.refresh();
        print(tokenRefresh.isTokenValid);

        if (tokenRefresh.isTokenValid) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}
