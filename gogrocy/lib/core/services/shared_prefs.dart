import 'package:gogrocy/core/models/Address.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

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
  setCartPrice(String s) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", s);
  }

  Future<String> getCartPrice() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart');
  }

  Future<bool> setCity(String s)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("city", s);
  }

  Future<String> getCity() async{
    final Apis apis = locator<Apis>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String city=prefs.getString("city");
    if(city==null){
      List<Address> address=await apis.getAddresses();
      setCity(address[0].city);
      return address[0].city;
    }
    else return city;
  }

}
