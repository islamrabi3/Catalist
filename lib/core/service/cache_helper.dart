import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> init() async {
    return prefs = await SharedPreferences.getInstance();
  }
}
