import 'dart:convert';
import 'package:http/http.dart';
import '/Configs/paths.dart';

class LoginModal {
  String mobile;
  String url = Paths.serverUrl + Paths.loginPath;
  Map response;

  LoginModal({this.mobile});

  Future<bool> loginUser() async {
    try {
      Response res =
          await post(Uri.parse(url), body: {"username": "DR_" + mobile});

      print(res.statusCode);
      print(res.body.runtimeType);

      response = jsonDecode(res.body);

      if (res.statusCode == 200) {
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

  Map responseServer() {
    Map result = {
      'response': response['response'],
    };

    return result;
  }
}
