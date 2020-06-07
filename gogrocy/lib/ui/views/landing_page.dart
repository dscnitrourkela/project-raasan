import 'dart:ui';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/view_carousel.dart';
import 'package:gogrocy/ui/widgets/appbars/main_appbar.dart';
import 'package:gogrocy/ui/widgets/bottom_navbar.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageView extends StatelessWidget {
  int _initialPage;

  HomePageView({int startingPage}) {
    _initialPage = startingPage ?? 1;
    if (startingPage == null) {
      print("Starting page is null");
    } else
      print("Starting page is not null, value is $_initialPage");
  }

  @override
  Widget build(BuildContext context) {
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }

    // TODO: implement build
    constants.mediaQueryData = MediaQuery.of(context);
    return ChangeNotifierProvider<BottomNavBarProvider>(
        create: (BuildContext context) =>
            BottomNavBarProvider(initialPage: _initialPage),
        child: Consumer<BottomNavBarProvider>(builder: (context, counter, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MainAppBar(),
              body: ViewCarousel(),
              bottomNavigationBar: BottomNavBar(_initialPage),
            ),
          );
        }));
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

  _showVersionDialog(context, URL_PLAYSTORE) async {
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
                onPressed: () => _launchURL(URL_PLAYSTORE),
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
