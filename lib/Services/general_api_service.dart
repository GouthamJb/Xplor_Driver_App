import '/Configs/paths.dart';
import 'cache_services.dart';
import 'check_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  ApiService();
  var response;
  Future<bool> getRequests(pageUrl) async {
    CacheService cacheService = new CacheService();
    String accessToken = await cacheService.getAccessToken();
    String url = Paths.serverUrl + pageUrl;
    if (await CheckAuth().checkUserAuth()) {
      try {
        accessToken = await cacheService.getAccessToken();
        print(accessToken);
        Response res = await get(
          Uri.parse(url),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "Content-Type": "application/json"
          },
        );

        print(res.statusCode);
        //print(res.body);

        response = jsonDecode(res.body);

        if (res.statusCode == 200) {
          return true;
        } else {
          response = {
            'success': false,
            'details': {'message': 'Token Invalid'},
            'response': 'tokenExpired'
          };
          return false;
        }
      } catch (e) {
        print('Caught error : $e');
        response = {
          'success': false,
          'details': {'message': 'Something went wrong!'},
          'response': 'Something went wrong!'
        };
        return false;
      }
    } else {
      print('auth check failed !');
      response = {
        'success': false,
        'details': {'message': 'Token has Expired'},
        'response': 'tokenExpired'
      };
      return false;
    }
  }

  Future<bool> postRequests(pageUrl, Map body) async {
    CacheService cacheService = new CacheService();
    String accessToken = await cacheService.getAccessToken();
    String url = Paths.serverUrl + pageUrl;
    print(pageUrl);
    if (await CheckAuth().checkUserAuth()) {
      try {
        accessToken = await cacheService.getAccessToken();
        print(accessToken);
        Response res = await post(Uri.parse(url),
            headers: {
              "Authorization": "Bearer " + accessToken,
              "Content-Type": "application/json"
            },
            body: jsonEncode(body));

        print(res.statusCode);
        print(res.body);

        response = jsonDecode(res.body);

        if (res.statusCode == 200) {
          return true;
        } else {
          /* response = {
            'success': false,
            'details': {'message': 'Token Invalid'},
            'response': 'tokenExpired' */
          //};
          return false;
        }
      } catch (e) {
        print('Caught error : $e');
        response = {
          'success': false,
          'details': {'message': 'Something went wrong!'},
          'response': 'Something went wrong!'
        };
        return false;
      }
    } else {
      print('auth check failed !');
      response = {
        'success': false,
        'details': {'message': 'Token has Expired'},
        'response': 'tokenExpired'
      };
      return false;
    }
  }

  Map<String, dynamic> getResponse() {
    print(response);
    return response;
  }
}
