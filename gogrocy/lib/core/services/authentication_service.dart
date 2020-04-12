import 'dart:async';

import 'package:gogrocy/core/models/user.dart';

class AuthenticationService{
  StreamController<User> userController = StreamController<User>();

  Future<bool> login() async{
    var fetchedUSer;

    var hasUser = fetchedUSer!=null;
    if(hasUser){
      userController.add(fetchedUSer);
    }

    return hasUser;
  }
}