import 'dart:ui';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/services/analytics_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/router.dart';
import 'package:gogrocy/ui/shared/colors.dart';
import 'package:gogrocy/ui/views/startup_view.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  //Crashlytics.instance.enableInDevMode = true;
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;
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
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      navigatorObservers: [
        locator<AnalyticsService>().getAnalyticsObserver(),

      ],
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

  versionCheck(context) async {
    //Get Current installed version of app
    await Future.delayed(Duration(milliseconds: 50));
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('latest_production_build_no');
      double newVersion = double.parse(remoteConfig
          .getString('latest_production_build_no')
          .trim()
          .replaceAll(".", ""));
      print(newVersion.toString() + " new versioon");
      print(currentVersion);

      if (newVersion > currentVersion) {
        _showVersionDialog(context, constants.playStoreUrl);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context, playStoreUrl) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now to avail new features.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text(btnLabel),
                onPressed: () => _launchURL(playStoreUrl),
              ),
              FlatButton(
                child: Text(btnLabelCancel),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
