import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/router.dart';
import 'package:gogrocy/ui/shared/colors.dart';
import 'package:gogrocy/ui/views/startup_view.dart';

void main() {
  setupLocator();
  runApp(GoGrocyApp());
}

class GoGrocyApp extends StatefulWidget {
  @override
  _GoGrocyAppState createState() => _GoGrocyAppState();
}

class _GoGrocyAppState extends State<GoGrocyApp> {
  //int _page = 0;
  //GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoGrocy',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: primaryColor,
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: StartupView(),
      //initialRoute: 'login',
      onGenerateRoute: generateRoute,
    );
  }
}
