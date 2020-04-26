import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/sign_up_arguments.dart';
import 'package:gogrocy/ui/views/signup_view.dart';
import 'package:gogrocy/ui/views/landing_page.dart';
import 'package:gogrocy/ui/views/login_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => LoginView());
    case 'home':
      return MaterialPageRoute(builder: (context) => HomePageView());
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
      SignUpArguments args = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SignUpView(
            mobile: args.mobile,
            countryCode: args.countryCode,
          );
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
