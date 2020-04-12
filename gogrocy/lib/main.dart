import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/router.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/login_view.dart';

void main() {
  setupLocator();
  runApp(GoGrocyApp());
}

class GoGrocyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoGrocy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: LoginView(),
     initialRoute: 'login',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
