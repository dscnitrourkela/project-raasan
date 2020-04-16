import 'package:flutter/material.dart';
import 'package:gogrocy/ui/views/awesome_animation_view.dart';
import 'package:gogrocy/ui/views/home/home.dart';
import 'package:gogrocy/ui/views/login_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => LoginView());
    case 'home':
      return MaterialPageRoute(builder: (context) => Home());
    case 'login':
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return LoginView();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    case 'awesome':
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AwesomeAnimationView();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
