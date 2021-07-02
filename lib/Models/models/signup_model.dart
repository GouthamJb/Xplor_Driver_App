import 'dart:convert';
import 'package:http/http.dart';
import '/Configs/paths.dart';

class SignUpModal {
  String name, mobile;
  String url = Paths.serverUrl + Paths.signUpPath;
  Map response;

  SignUpModal({this.name, this.mobile});

  Future<bool> signUpUser() async {
    try {
      Response res = await post(Uri.parse(url),
          body: {"username": "DR_" + mobile, "first_name": name});

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
}
