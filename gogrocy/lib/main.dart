import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/dummy_views.dart';
import 'package:gogrocy/ui/views/landing_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'GoGrocy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePageView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    print(constants.LoginSizeConfig.loginIllustrationWidth.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'GOGROCY',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
