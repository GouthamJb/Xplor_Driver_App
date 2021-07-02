import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  CacheService();

  // write functions
  Future writeStringToCache(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  void writeStringListToCache(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, value);
  }

  void writeIntToCache(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  void writeBoolToCache(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  // Read functions
  Future<String> readStringFromCache(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<List<String>> readStringListFromCache(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }

  Future<int> readIntFromCache(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }

  Future<bool> readBoolFromCache(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  Future<dynamic> readFromCache(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }

  // Misc functions
  Future<bool> isKeyExists(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(key);
  }

  void removeEntry(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  void removeAllCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  // Token functions
  Future<String> getAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('accessToken');
  }

  Future<String> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('refreshToken');
  }
}
