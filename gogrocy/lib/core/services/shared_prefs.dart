import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences _sharedPrefs;

  SharedPrefs() {
    initSharedPrefs();
  }

  initSharedPrefs() async{
    _sharedPrefs=await SharedPreferences.getInstance();
  }

  setJWT(String s) async{
    _sharedPrefs.setString("jwt",s);
  }

  Future<String> getJWT() async{
    String jwt =  _sharedPrefs.getString("jwt");
    return jwt;
  }

}
