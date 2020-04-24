import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  Future<bool> setJWT(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("jwt", s);
  }

  Future<String> getJWT() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt");
  }

  Future<bool> setLoggedIn(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("loggedIn", t);
  }

  Future<bool> hasUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loggedIn")??false;
  }
}
