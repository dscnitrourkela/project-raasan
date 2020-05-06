import 'package:gogrocy/core/services/fcm_subscribe_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class SharedPrefsService {

  final FCMSubscription _fcmSubscription=FCMSubscription();


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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loggedIn") ?? false;
  }

  setCartPrice(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", s);
  }

  Future<String> getCartPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart');
  }

  Future<bool> setCity(String s) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var citySelected = (await getCity()) != null;
    if(citySelected){
      _fcmSubscription.fcmUnSubscribe(await getCity());
      _fcmSubscription.fcmSubscribe(s);
    }
    else
      _fcmSubscription.fcmSubscribe(s);
    return prefs.setString("city", s);
  }

  Future<String> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String city = prefs.getString("city");
    if (city == null) {
      //List<Address> address=await apis.getAddresses();
      //setCity(address[0].city);
      return null;
    } else {
      print(city);
      return city;
    }
  }
}
