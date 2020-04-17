import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/router.dart';
import 'package:gogrocy/ui/views/startup_view.dart';

void main() {
  setupLocator();
  runApp(GoGrocyApp());
}

class GoGrocyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoGrocy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: StartupView(),
      //initialRoute: 'login',
      onGenerateRoute: generateRoute,
    );
  }
}
